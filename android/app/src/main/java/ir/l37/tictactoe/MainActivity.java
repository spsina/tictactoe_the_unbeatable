package ir.l37.tictactoe;

import androidx.annotation.NonNull;

import java.lang.reflect.Method;

import io.flutter.Log;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

import ir.tapsell.sdk.Tapsell;
import ir.tapsell.sdk.TapsellAdRequestListener;
import ir.tapsell.sdk.TapsellAdRequestOptions;
import ir.tapsell.sdk.TapsellAdShowListener;
import ir.tapsell.sdk.TapsellShowOptions;
public class MainActivity extends FlutterActivity {
    String zone_id_reward = "5eafd67811bba80001b9c891";
    String zone_id_instant = "5eafec4d693e0800019cc8c2";

    static boolean done = false;
    static boolean busy = false;

    private static final String CHANNEL = "ir.l37.tictactoe/tapsell";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {

        try {
            Class<?> generatedPluginRegistrant =
                    Class.forName("io.flutter.plugins.GeneratedPluginRegistrant");
            Method registrationMethod =
                    generatedPluginRegistrant.getDeclaredMethod("registerWith", FlutterEngine.class);
            registrationMethod.invoke(null, flutterEngine);
        } catch (Exception e) {
            Log.w(
                    "ERROR",
                    "Tried to automatically register plugins with FlutterEngine ("
                            + flutterEngine
                            + ") but could not find and invoke the GeneratedPluginRegistrant.");
        }

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("requestAndShowReward")) {
                                requestAndShow(zone_id_reward, true);
                            } else if (call.method.equals("requestAndShowInstant")) {
                                requestAndShow(zone_id_instant, false);
                            }
                        }
                );
    }

    void requestAndShow(String zone, boolean isReward) {

        // set up show options
        TapsellShowOptions showOptions = new TapsellShowOptions();
        if (isReward) {
            showOptions.setBackDisabled(true);
            showOptions.setShowDialog(true);
        } else {
            showOptions.setBackDisabled(false);
            showOptions.setShowDialog(false);
        }

        // don't allow rotation
        showOptions.setRotationMode(TapsellShowOptions.ROTATION_LOCKED_PORTRAIT);

        try {

            // request ad
            Tapsell.requestAd(
                    getApplicationContext(),
                    zone,
                    new TapsellAdRequestOptions(),
                    new TapsellAdRequestListener() {
                        // handle ad request results

                        @Override
                        public void onAdAvailable(String adId) {
                            Tapsell.showAd(getApplicationContext(),
                                    zone,
                                    adId,
                                    showOptions,
                                    new TapsellAdShowListener() {
                                        @Override
                                        public void onOpened() {
                                            Log.i("INFO", "Ad OPENED");
                                        }

                                        @Override
                                        public void onClosed() {
                                            Log.i("INFO", "Ad closed");
                                        }

                                        @Override
                                        public void onError(String message) {
                                            Log.e("ERROR", "show add error");
                                        }

                                        @Override
                                        public void onRewarded(boolean completed) {
                                            Log.i("INFO", "ALL DONE");
                                        }
                                    });
                        }

                        @Override
                        public void onError(String message) {
                            Log.e("ERROR", "Request ad error");
                        }
                    }

            );
        }
        catch (Exception e) {
            Log.e("EXCEPTION ERROR", e.toString());
        }
    }
}
