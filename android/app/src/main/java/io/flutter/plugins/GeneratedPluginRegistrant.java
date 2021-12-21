package io.flutter.plugins;

import androidx.annotation.Keep;
import androidx.annotation.NonNull;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry;

/**
 * Generated file. Do not edit.
 * This file is generated by the Flutter tool based on the
 * plugins that support the Android platform.
 */
@Keep
public final class GeneratedPluginRegistrant {
  public static void registerWith(@NonNull FlutterEngine flutterEngine) {
    ShimPluginRegistry shimPluginRegistry = new ShimPluginRegistry(flutterEngine);
      com.shatsy.admobflutter.AdmobFlutterPlugin.registerWith(shimPluginRegistry.registrarFor("com.shatsy.admobflutter.AdmobFlutterPlugin"));
    flutterEngine.getPlugins().add(new io.flutter.plugins.connectivity.ConnectivityPlugin());
    flutterEngine.getPlugins().add(new io.flutter.plugins.firebaseanalytics.FirebaseAnalyticsPlugin());
    flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.core.FlutterFirebaseCorePlugin());
    flutterEngine.getPlugins().add(new io.flutter.plugins.firebasemlvision.FirebaseMlVisionPlugin());
    flutterEngine.getPlugins().add(new com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin());
      com.nover.flutternativeadmob.FlutterNativeAdmobPlugin.registerWith(shimPluginRegistry.registrarFor("com.nover.flutternativeadmob.FlutterNativeAdmobPlugin"));
    flutterEngine.getPlugins().add(new io.flutter.plugins.flutter_plugin_android_lifecycle.FlutterAndroidLifecyclePlugin());
    flutterEngine.getPlugins().add(new com.example.fluttershare.FlutterSharePlugin());
      com.flutter.text_to_speech.FlutterTextToSpeechPlugin.registerWith(shimPluginRegistry.registrarFor("com.flutter.text_to_speech.FlutterTextToSpeechPlugin"));
    flutterEngine.getPlugins().add(new com.tundralabs.fluttertts.FlutterTtsPlugin());
    flutterEngine.getPlugins().add(new vn.hunghd.flutter.plugins.imagecropper.ImageCropperPlugin());
    flutterEngine.getPlugins().add(new io.flutter.plugins.imagepicker.ImagePickerPlugin());
    flutterEngine.getPlugins().add(new io.flutter.plugins.pathprovider.PathProviderPlugin());
    flutterEngine.getPlugins().add(new com.baseflow.permissionhandler.PermissionHandlerPlugin());
    flutterEngine.getPlugins().add(new io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin());
      bz.rxla.flutter.speechrecognition.SpeechRecognitionPlugin.registerWith(shimPluginRegistry.registrarFor("bz.rxla.flutter.speechrecognition.SpeechRecognitionPlugin"));
    flutterEngine.getPlugins().add(new com.csdcorp.speech_to_text.SpeechToTextPlugin());
    flutterEngine.getPlugins().add(new io.flutter.plugins.urllauncher.UrlLauncherPlugin());
  }
}
