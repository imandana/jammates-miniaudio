package com.example.jammates_miniaudio;

import android.os.Bundle;
import android.util.Log;

import androidx.annotation.NonNull;
import java.util.List;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/// For MiniAudio Library
import com.jenggotmalam.MiniAudioPlayer;

public class MainActivity extends FlutterActivity {
    private MethodChannel methodChannel;

	private MiniAudioPlayer miniAudioPlayer;
	
	@Override
    protected void onCreate(Bundle savedInstanceState) {
//        super.onCreate(savedInstanceState);
//
//		/// Init the Miniaudio player
//		miniAudioPlayer = new MiniAudioPlayer( this );
//
//		// Start audio thread
//		miniAudioPlayer.StartAudioThread();
//
//		/// Add music together
//		miniAudioPlayer.AddMusicStreamToPlay("audio/bass.mp3");
//		miniAudioPlayer.AddMusicStreamToPlay("audio/drum.mp3");
//		miniAudioPlayer.AddMusicStreamToPlay("audio/piano.mp3");
//
//
//		/// Set Volume
//		miniAudioPlayer.SetMusicVolumeOf("audio/bass.mp3", 1.0f);
//		miniAudioPlayer.SetMusicVolumeOf("audio/drum.mp3", 0.5f);
//		miniAudioPlayer.SetMusicVolumeOf("audio/piano.mp3", 0.2f);
        super.onCreate(savedInstanceState);

        miniAudioPlayer = new MiniAudioPlayer(this);
        miniAudioPlayer.StartAudioThread();
    }
	
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        // Commands received from Flutter code:
        methodChannel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), "method_channel");
        methodChannel.setMethodCallHandler((call, result) -> {
            switch (call.method) {
                case "initPlayer":
                    // Initialize your player here based on audio tracks received from Flutter

                    List<String> audioTracks = (List<String>) call.argument("audioTracks");
                    for (String track : audioTracks) {
                        miniAudioPlayer.AddMusicStreamFromStorage("/storage/emulated/0/Android/data/com.example.jammates_miniaudio/files/" + track + ".mp3");
//                        miniAudioPlayer.AddMusicStreamFromStorage("/data/user/0/com.example.jammates_miniaudio/files/" + track + ".mp3");
                    }

//                    Log.d("TAG", "initPlayer: STARTED" + call.argument("audioTracks"));
                    break;
                case "playSound":
                    Log.d("TAG", "Play sound: " + call.argument("text"));
					
					miniAudioPlayer.PlayAllAudio();
					
                    break;
                case "stopSound":
                    Log.d("TAG", "Stop sound: " + call.argument("text"));
					
					// Not implemented yet
					
                    break;
                case "pauseSound":
                    Log.d("TAG", "Stop sound: " + call.argument("text"));

                    miniAudioPlayer.PauseAllAudio();

                    break;
                case "resumeSound":
                    Log.d("TAG", "Stop sound: " + call.argument("text"));

                    miniAudioPlayer.ResumeAllAudio();

                    break;
                case "updateDrumVolume":
                    float drumVolume = ((Number) call.argument("volume")).floatValue();
                    Log.d("TAG", "Drum volume updated: " + drumVolume);
                    miniAudioPlayer.SetMusicVolumeOf("audio/drum.mp3", drumVolume);
                    break;
                case "updateBassVolume":
                    float bassVolume = ((Number) call.argument("volume")).floatValue();
                    Log.d("TAG", "Bass volume updated: " + bassVolume);
                    miniAudioPlayer.SetMusicVolumeOf("audio/bass.mp3", bassVolume);
                    break;
                case "updatePianoVolume":
                    float pianoVolume = ((Number) call.argument("volume")).floatValue();
                    Log.d("TAG", "Piano volume updated: " + pianoVolume);
                    miniAudioPlayer.SetMusicVolumeOf("audio/piano.mp3", pianoVolume);
                    break;
                default:

                    Log.e("TAG", "ERROR");
                    break;
            }
            result.success(null); // Indicate successful handling of the method call
        });
    }

}
