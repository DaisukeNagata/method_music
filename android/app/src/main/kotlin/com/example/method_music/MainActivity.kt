package com.example.method_music

import android.media.*
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.util.Log
import androidx.annotation.RequiresApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.IOException
import java.nio.file.Paths
import kotlin.io.path.pathString

class MainActivity: FlutterActivity() {

    private lateinit var channel: MethodChannel
    companion object {
        private const val CHANNEL = "com.example.flutter_sound_audio/music"
        private var mediaPlayer = MediaPlayer()
        const val Log_Tag = "MainActivity"
    }
    @RequiresApi(Build.VERSION_CODES.O)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        channel = MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL)
        channel.setMethodCallHandler { methodCall: MethodCall, _: MethodChannel.Result ->
            val internal = applicationContext.filesDir
            val to1 = Paths.get(internal.path, methodCall.method)
            val filePath = Uri.parse(to1.pathString)
            mediaPlayer.apply {
                try {
                    setDataSource(context, filePath)
                    prepare()
                    start()
                } catch (e: IOException) {
                    Log.e(Log_Tag, "prepare() failed")
                }
            }
        }
    }
}
