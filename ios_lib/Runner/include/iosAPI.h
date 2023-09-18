
#ifndef IOS_API_H
#define IOS_API_H

#include <string.h>
#include <sys/types.h>
#include <stdio.h>              // Required for: printf()

#include "utils.h"
#include "raudio.h"

#define NUM_OF_MUSIC	11

int isClosed = 0;
//int pauseMusic = 0;
int isPlaying = 0;
int setPitchReady = 0;
int isNewMusicList = 0;
//int pitchValue = 0;
float currTimePos = 0.0f;
float musicLegth  = 1.0f;


/// IOS
NSMutableArray *array;
////
/// Using this for dynamic music load, but the MAX is fixed size
struct MusicListTogether
{
	Music music[ NUM_OF_MUSIC ];
	
	int indexToPlay[ NUM_OF_MUSIC ];
	int indexInActive[ NUM_OF_MUSIC ];
	int count; /// For looping
	
};

struct MusicListTogether musicListTogether;

#ifdef __cplusplus
extern "C" {            // Prevents name mangling of functions
#endif

void InitDeviceMiniaudio();
void ExecutePlayer();

void SetPitchAll( float );

void StartPlayer();
void StopPlayer();
void PausePlayer();
void ResumePlayer();
void CleanResource();

//// IOS Special 
void AddMusic(const char* path);
void RemoveMusicStream( int pos );
void SetVolumeForMusic(NSInteger index, float vol);

#ifdef __cplusplus
}
#endif

#endif /// IOS_API_H

