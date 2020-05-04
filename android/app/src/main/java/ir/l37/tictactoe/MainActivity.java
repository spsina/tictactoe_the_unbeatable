package ir.l37.tictactoe;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import ir.tapsell.sdk.Tapsell;
import ir.tapsell.sdk.TapsellAdRequestListener;
import ir.tapsell.sdk.TapsellAdRequestOptions;
import ir.tapsell.sdk.TapsellAdShowListener;
import ir.tapsell.sdk.TapsellShowOptions;
import ir.tapsell.sdk.bannerads.TapsellBannerType;
import ir.tapsell.sdk.bannerads.TapsellBannerView;

public class MainActivity extends FlutterActivity {
    String zone_id_full = "5eafec4d693e0800019cc8c2";
    String zone_id_banner = "5eaffb0611bba80001b9c8a7";

    private static final String CHANNEL = "ir.l37.tictactoe/tapsell";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("requestAndShow")) {
                                requestAndShow();
                                result.success("Method Called");
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }

    void requestAndShow() {
        TapsellShowOptions showOptions = new TapsellShowOptions();
        showOptions.setBackDisabled(true);
        showOptions.setShowDialog(true);
        showOptions.setRotationMode(TapsellShowOptions.ROTATION_LOCKED_PORTRAIT);
        Tapsell.requestAd(getApplicationContext(),
                zone_id_full,
            new TapsellAdRequestOptions(),
            new TapsellAdRequestListener() {
                @Override
                public void onAdAvailable(String adId) {
                    Tapsell.showAd(getApplicationContext(),
                            zone_id_full,
                        adId,
                        showOptions,
                        new TapsellAdShowListener() {
                            @Override
                            public void onOpened() {
                                System.out.println("Opened ");
                            }
                            @Override
                            public void onClosed() {
                                System.out.println("Closed ");
                            }

                            @Override
                            public void onError(String message) {
                                System.out.println("Error on show " + message);
                            }

                            @Override
                            public void onRewarded(boolean completed) {
                                System.out.println("Rewarded ");
                            }
                        });
                }

                @Override
                public void onError(String message) {
                    System.out.println("Error on request " + message + "______________");
                }
            });
    }
}
