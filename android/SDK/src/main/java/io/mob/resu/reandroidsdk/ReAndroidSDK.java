package io.mob.resu.reandroidsdk;

import static io.mob.resu.reandroidsdk.AppConstants.CustomEvents;
import static io.mob.resu.reandroidsdk.AppConstants.NOTIFICATION_EXPIRED;
import static io.mob.resu.reandroidsdk.AppConstants.appOpenTime;
import static io.mob.resu.reandroidsdk.AppConstants.retrycout;
import static io.mob.resu.reandroidsdk.AppConstants.sessionId;
import static io.mob.resu.reandroidsdk.AppConstants.socketLiveDashboard;

import android.app.AlarmManager;
import android.app.Application;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.os.SystemClock;
import android.text.TextUtils;
import android.util.Base64;
import android.widget.Toast;

import androidx.core.app.NotificationManagerCompat;

import com.android.installreferrer.api.InstallReferrerClient;
import com.android.installreferrer.api.InstallReferrerStateListener;
import com.android.installreferrer.api.ReferrerDetails;

import org.json.JSONObject;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.net.URISyntaxException;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.Executor;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

import io.mob.resu.reandroidsdk.error.ExceptionTracker;
import io.mob.resu.reandroidsdk.error.Log;
import io.socket.client.IO;
import io.socket.client.Socket;
import io.socket.emitter.Emitter;

/**
 * @hide #doInBackground
 * @hide #onRestoreInstanceState
 * @hide #onPostCreate
 * @see #ReAndroidSDK
 */
public class ReAndroidSDK {
    public static Bitmap image = null;
    public void getImage(String base64code){
 //       AppConstants.hybridScreenShot = base64code;
        byte[] decodedString = Base64.decode(base64code, Base64.DEFAULT);
        Bitmap decodedByte = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);
        AppConstants.hybridScreenShotBitmap = decodedByte;
    }
    private static final String TAG = ReAndroidSDK.class.getSimpleName();
    public static JSONObject AppInfo = null;

    public static onPageChangeListener onPageChangeListener = new onPageChangeListener() {

        @Override
        public void onPageChanged(String activityName, String fragmentName) {
           /* try {
                //  socketConnect();
                //  emitNewUser( activityName,  fragmentName);
            } catch (Exception e) {
                e.printStackTrace();
            }*/
        }
    };

    static ActivityLifecycleCallbacks activityLifecycleCallbacks;
    static String appID;
    static Context appContext;
    private static ReAndroidSDK tracker;
    /**
     * Socket Live audience dashboard
     */
    Socket mSocket;
    boolean isConnected = false;
    /**
     * Socket onConnect
     */

    private Emitter.Listener onConnect = new Emitter.Listener() {
        @Override
        public void call(Object... args) {
            try {
                isConnected = true;
                if (activityLifecycleCallbacks.mActivity != null)
                    emitNewUser(activityLifecycleCallbacks.mActivity.getClass().getSimpleName(), FragmentLifecycleCallbacks.newScreenName);
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
    };
    private Emitter.Listener onMessage = new Emitter.Listener() {
        @Override
        public void call(Object... args) {
            try {
                emitNewUser("", "");
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
    };

    /**
     * @hide
     */
    private ReAndroidSDK(Context context) {
        try {
            appContext = context;
            registerActivityCallBacks(context);
            new InstallReferrer().executeOnExecutor(context);
            new getAppID(context).execute();

        } catch (Exception e) {
            ExceptionTracker.track(e);
        }

    }


    /**
     * @hide
     */
    public static ReAndroidSDK getInstance(Context context) {
        try {
            appContext = context;

            if (tracker == null) {
                return tracker = new ReAndroidSDK(context);
            } else
                return tracker;
        } catch (Exception e) {
            ExceptionTracker.track(e);
        }
        return tracker;
    }
    public ArrayList<JSONObject> getFieldTrackList() {
        try {
            if(DataExchanger.fieldCaptureList != null) {
                return DataExchanger.fieldCaptureList;
            }
        }catch (Exception e){
            ExceptionTracker.track(e);
        }
        return null;
    }


    static void GetAppInfo(Context context) {
        try {
            ExecutorService executor = Executors.newSingleThreadExecutor();
            executor.execute(() -> {
                try {
                    if (AppInfo == null)
                        AppInfo = Util.getAppDetails(context);
                } catch (Exception e) {
                }
            });
        } catch (Exception e) {

        }
    }

    static void onDBCheck(Context context) {
        try {
            ExecutorService executor = Executors.newSingleThreadExecutor();
            executor.execute(() -> {
                try {
                    try {
                        if (new DataBase(context).getCount(DataBase.Table.CAMPAIGN_TABLE) > 2) {
                            Log.e("DB_DELETE", "CAMPAIGN_TABLE");
                            Log.e("DB_DELETE", "CAMPAIGN_TABLE");
                            Log.e("DB_DELETE", "CAMPAIGN_TABLE");
                            Log.e("DB_DELETE", "CAMPAIGN_TABLE");
                            new DataBase(context).deleteEventTable(DataBase.Table.CAMPAIGN_TABLE);
                        }
                    } catch (Exception e) {

                    }
                    try {
                        if (new DataBase(context).getCount(DataBase.Table.SCREENS_TABLE) > 2) {
                            Log.e("DB_DELETE", "SCREENS_TABLE");
                            Log.e("DB_DELETE", "SCREENS_TABLE");
                            Log.e("DB_DELETE", "SCREENS_TABLE");
                            Log.e("DB_DELETE", "SCREENS_TABLE");
                            new DataBase(context).deleteEventTable(DataBase.Table.SCREENS_TABLE);
                        }
                    } catch (Exception e) {

                    }
                    try {
                        if (new DataBase(context).getCount(DataBase.Table.EVENT_TABLE) > 2) {
                            Log.e("DB_DELETE", "EVENT_TABLE");
                            Log.e("DB_DELETE", "EVENT_TABLE");
                            Log.e("DB_DELETE", "EVENT_TABLE");
                            Log.e("DB_DELETE", "EVENT_TABLE");
                            new DataBase(context).deleteEventTable(DataBase.Table.EVENT_TABLE);
                        }
                    } catch (Exception e) {

                    }


                } catch (Exception e) {

                }
            });
        } catch (Exception e) {

        }

    }

    public static ArrayList<JSONObject> getFieldTrackData(String screenName) {

        try {
            return new DataBase(appContext).getFieldTrackingList(DataBase.Table.REGISTER_EVENT_TABLE, screenName);
        } catch (Exception e) {
            return new ArrayList<>();
        }
    }

    /**
     * Event type: 3
     */
    public void appConversionTracking() {
        try {
            DataNetworkHandler.getInstance().apiCallAppConversionTracking(appContext);
        } catch (Exception e) {
            ExceptionTracker.track(e);
        }
    }

    /**
     * Event type: 3
     */
    public void appConversionTracking(JSONObject jsonObject) {
        try {
            DataNetworkHandler.getInstance().apiCallAppConversionTracking(appContext, jsonObject);
        } catch (Exception e) {
            ExceptionTracker.track(e);
        }
    }

    /**
     * @hide
     */

    public void getCampaignData(IDeepLinkInterface deepLinkInterface) {
        try {
            if (SharedPref.getInstance().getBooleanValue(appContext, AppConstants.reApiParamIsNewUser)) {
                DataNetworkHandler.getInstance().getCampaignDetails(appContext, deepLinkInterface, null);
            } else if (SharedPref.getInstance().getBooleanValue(appContext, AppConstants.reDeepLinkParamIsViaDeepLinkingLauncher)) {
                DataNetworkHandler.getInstance().getCampaignDetails(appContext, deepLinkInterface, null);
            }
        } catch (Exception e) {

        }
    }

    public void addNewNotification(String title, String body, String activityName, String fragmentName, JSONObject customParams) {
        try {
            addLocalNotification(title, body, activityName, fragmentName, customParams);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void addNewNotification(String title, String body, String activityName, String fragmentName) {
        try {
            addLocalNotification(title, body, activityName, fragmentName, new JSONObject());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void addNewNotification(String title, String body, String activityName) {
        try {
            addLocalNotification(title, body, activityName, "", new JSONObject());
        } catch (Exception e) {

        }
    }

    private void addLocalNotification(String title, String body, String activityName, String fragmentName, JSONObject customParams) {
        try {
            Bundle jsonObject = new Bundle();
            jsonObject.putString("duration", "1 Minute(s)");
            jsonObject.putString("rating", "");
            jsonObject.putString("id", "" + System.currentTimeMillis());
            jsonObject.putString("url", "");
            jsonObject.putString("body", body);
            jsonObject.putString("category", fragmentName);
            jsonObject.putString("title", title);
            jsonObject.putString("customParams", customParams.toString());
            jsonObject.putString("deliveryType", "0");
            jsonObject.putString("navigationScreen", activityName);
            jsonObject.putString("pushType", "1");
            jsonObject.putString("actionName", "Maybe Later");
            jsonObject.putString("MobileFriendlyUrl", "");
            ReAndroidSDK.getInstance(appContext).onReceivedCampaign(jsonObject);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    private void getNotificationAsserts(Context context) {
        try {

            if (TextUtils.isEmpty(SharedPref.getInstance().getStringValue(context, "notificationIcon"))) {
                SharedPref.getInstance().setSharedValue(context, "notificationIcon", Util.getMetaDataValues(context, "resulticks.default_notification_icon", "notification icon"));
            }
            if (TextUtils.isEmpty(SharedPref.getInstance().getStringValue(context, "notificationTransparent"))) {
                SharedPref.getInstance().setSharedValue(context, "notificationTransparent", Util.getMetaDataValues(context, "resulticks.default_notification_icon_transparent", "notification icon transparent"));
            }
            if (TextUtils.isEmpty(SharedPref.getInstance().getStringValue(context, "notificationColor"))) {
                SharedPref.getInstance().setSharedValue(context, "notificationColor", Util.getMetaDataValues(context, "resulticks.default_notification_color", "notification color"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }


    }

    /**
     * smart link Data provider
     */
    public String getDeepLinkData() {
        try {
            if (!TextUtils.isEmpty(SharedPref.getInstance().getStringValue(appContext, AppConstants.reSharedReferral))) {
                return SharedPref.getInstance().getStringValue(appContext, AppConstants.reSharedReferral);
            }

        } catch (Exception e) {
            ExceptionTracker.track(e);

        }

        return "";
    }

    /**
     * FCM OR GCM token receive
     *
     * @param modelRegisterUser
     */
    public void onDeviceUserRegister(MRegisterUser modelRegisterUser) {
        try {
            apiCallRegister(modelRegisterUser);
            AppRuleListener.getInstance().processUserTypeChangeRules(appContext);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * FCM Notification Receiver
     *
     * @param data
     * @return
     */
    public boolean onReceivedCampaign(Map<String, String> data) {
        try {

            if (data.containsKey("resul")) {
                String ps = data.get("resul");
                int length = ps.length();
                ps = ps.substring(4, length);
                Log.e("value1", ps);
                byte[] tmp2 = Base64.decode(ps, Base64.DEFAULT);
                String val2 = new String(tmp2, StandardCharsets.UTF_8);
                Log.e("value", val2);
                JSONObject jsonObject = new JSONObject(val2);
                Bundle bundle = new Bundle();
                Iterator<String> stringSet = jsonObject.keys();
                while (stringSet.hasNext()) {
                    String key = stringSet.next();
                    String value = jsonObject.getString(key);
                    bundle.putString(key, value);
                }
                onReceivedCampaign(bundle);
                return true;
            } else if (data.containsKey("navigationScreen")) {
                notificationValidationMap(data);
                return true;
            } else {
                return false;
            }

        } catch (Exception e) {
            ExceptionTracker.track(e);
        }
        return false;
    }

    /**
     * GCM Notification Receiver
     *
     * @param data
     * @return
     */
    public boolean onReceivedCampaign(Bundle data) {

        try {
            if (data.containsKey("resul")) {
                String ps = data.getString("resul");
                int length = ps.length();
                ps = ps.substring(5, length);
                Log.e("value1", ps);
                byte[] tmp2 = Base64.decode(ps, Base64.DEFAULT);
                String val2 = null;
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
                    val2 = new String(tmp2, StandardCharsets.UTF_8);
                }
                Log.e("value", val2);
                JSONObject jsonObject = new JSONObject(val2);
                Bundle bundle = new Bundle();
                Iterator<String> stringSet = jsonObject.keys();
                while (stringSet.hasNext()) {
                    String key = stringSet.next();
                    String value = jsonObject.getString(key);
                    bundle.putString(key, value);
                }
                onReceivedCampaign(bundle);
                return true;
            } else if (data.containsKey("navigationScreen")) {
                if (data.containsKey("isCarousel")) {
                    if (Boolean.parseBoolean(data.getString("isCarousel"))) {
                        if (data.containsKey("carousel")) {
                            notificationValidation(data);
                        } else {
                            try {
                                JSONObject jsonObject = new JSONObject();
                                jsonObject.put("url", AppConstants.CarosualUrl + "=" + data.getString("id"));
                                new DataNetworkHandler().apiCallGetCarouselNotification(appContext, jsonObject);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        }
                    } else {
                        notificationValidation(data);
                    }
                } else {
                    notificationValidation(data);
                }
                return true;
            } else {
                return false;
            }
        } catch (Exception e) {
            ExceptionTracker.track(e);
        }
        return false;
    }

    private void notificationValidation(Bundle data) {

        try {
            ExecutorService executor = Executors.newSingleThreadExecutor();
            Handler handler = new Handler(Looper.getMainLooper());
            executor.execute(() -> {
                boolean flag = false;
                try {
                    if (data.containsKey("ttl")) {
                        if (TextUtils.isEmpty(data.getString("ttl")) || Util.isExpired("" + data.get("ttl"))) {
                            flag = true;
                        }
                    } else {
                        flag = true;
                    }

                    //Background work here
                    //UI Thread work here
                    boolean finalFlag = flag;
                    handler.post(() -> {
                        //UI Thread work here
                        try {
                            if (finalFlag) {
                                new NotificationHelper(appContext).handleDataMessage(data);
                            } else {

                                if (data.containsKey("isAMP")) {
                                    boolean isEnd = data.getBoolean("isEND");
                                    new OfflineCampaignTrack(appContext, data.getString("id"), NOTIFICATION_EXPIRED, true, isEnd, DataNetworkHandler.getInstance()).execute();
                                } else {
                                    new OfflineCampaignTrack(appContext, data.getString("id"), NOTIFICATION_EXPIRED, "Notification expired", false, null, null, DataNetworkHandler.getInstance()).execute();
                                }
                            }
                        } catch (Exception e) {

                        }

                    });
                } catch (Exception e) {
                    e.printStackTrace();
                }
            });

          /*  if (data.containsKey("ttl")) {
                if (TextUtils.isEmpty(data.getString("ttl")) || Util.isExpired("" + data.get("ttl"))) {
                    new NotificationHelper(appContext).handleDataMessage(data);
                } else {
                    Log.e("notification", "Expired");
                    if (data.containsKey("isAMP")) {
                        boolean isEnd = data.getBoolean("isEND");
                        new OfflineCampaignTrack(appContext, data.getString("id"), NOTIFICATION_EXPIRED, true, isEnd, DataNetworkHandler.getInstance()).execute();
                    } else {
                        new OfflineCampaignTrack(appContext, data.getString("id"), NOTIFICATION_EXPIRED, "Notification expired", false, null, null, DataNetworkHandler.getInstance()).execute();
                    }
                }
            } else {
                new NotificationHelper(appContext).handleDataMessage(data);
            }
*/

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    private void notificationValidationMap(Map<String, String> data) {
        try {
            if (data.containsKey("ttl")) {
                if (TextUtils.isEmpty(data.get("ttl")) || Util.isExpired("" + data.get("ttl"))) {
                    new NotificationHelper(appContext).handleDataMessage(data);
                } else {
                    Log.e("notification", "Expired");
                    if (data.containsKey("isAMP")) {
                        boolean isEnd = Boolean.parseBoolean(data.get("isEND"));
                        new OfflineCampaignTrack(appContext, data.get("id"), NOTIFICATION_EXPIRED, true, isEnd, DataNetworkHandler.getInstance()).execute();
                    } else {
                        new OfflineCampaignTrack(appContext, data.get("id"), NOTIFICATION_EXPIRED, "Notification expired", false, null, null, DataNetworkHandler.getInstance()).execute();
                    }
                }
            } else {
                new NotificationHelper(appContext).handleDataMessage(data);
            }
        } catch (Exception e) {

        }
    }

    private Intent getIntent(Map<String, String> map) {
        Intent intent = new Intent();
        try {
            JSONObject jsonObject = new JSONObject();

            for (String value : map.keySet()) {
                intent.putExtra(value, map.get(value));
                jsonObject.put(value, map.get(value));
            }
            Log.e("Push Notification", "" + jsonObject.toString());
            intent.putExtra("activityName", map.get("navigationScreen"));
            intent.putExtra("fragmentName", map.get("category"));
            intent.putExtra("notificationId", map.get("id").hashCode());
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
            return intent;
        } catch (Exception e) {
            ExceptionTracker.track(e);
        }
        return intent;

    }

    /**
     * User Moving Location update
     *
     * @param latitude
     * @param longitude
     */
    public void onLocationUpdate(double latitude, double longitude) {
        try {
            AppRuleListener.getInstance().processLocationRules(appContext, latitude, longitude);
            DataNetworkHandler.getInstance().apiCallUpdateLocation(appContext, Util.onLocationUpdate(appContext, latitude, longitude));
        } catch (Exception e) {
            ExceptionTracker.track(e);
        }
    }

    /**
     * Notification wise Delete
     *
     * @param
     */
    public void readNotification(String campaignId) {
        try {
            new DataBase(appContext).markRead(campaignId, DataBase.Table.NOTIFICATION_TABLE, true);
        } catch (Exception e) {

        }

    }

    /**
     * Notification wise Delete
     *
     * @param
     */
    public void unReadNotification(String campaignId) {
        try {
            new DataBase(appContext).markRead(campaignId, DataBase.Table.NOTIFICATION_TABLE, false);
        } catch (Exception e) {

        }
    }

    /**
     * Notification wise Delete
     *
     * @param
     */
    public void notificationCTAClicked(String campaignId, String actionId) {
        try {
            new DataBase(appContext).markRead(campaignId, DataBase.Table.NOTIFICATION_TABLE, true);
            new OfflineCampaignTrack(appContext, campaignId, AppConstants.NOTIFICATION_OPEN, "NOTIFICATION_CUSTOM_CTA", false, null, null, DataNetworkHandler.getInstance()).execute();

        } catch (Exception e) {

        }

    }

    /**
     * Get read Notification count
     *
     * @param
     */
    @Deprecated()
    public int getUnReadNotificationCount() {

        int count = 0;
        try {
            count = new DataBase(appContext).getNotificationCount(false, DataBase.Table.NOTIFICATION_TABLE);
        } catch (Exception e) {

        }
        return count;
    }

    public void getUnReadNotificationCount(IRNotifications reNotifications) {
        try {
            new getCount(reNotifications, false).execute();
        } catch (Exception e) {
            if (reNotifications != null)
                reNotifications.getUnreadCount(0);
        }
    }

    public void getReadNotificationCount(IRNotifications reNotifications) {
        try {
            new getCount(reNotifications, true).execute();
        } catch (Exception e) {
            if (reNotifications != null)
                reNotifications.getReadCount(0);
        }
    }


    public void getNotificationByObject(IRNotifications reNotifications) {
        try {
            new GetNotifications(reNotifications, true).execute();
        } catch (Exception e) {
            if (reNotifications != null)
                reNotifications.getNotificationByObject(new ArrayList<>());
        }
    }

    public void getNotifications(IRNotifications reNotifications) {
        try {
            new GetNotifications(reNotifications, false).execute();
        } catch (Exception e) {
            if (reNotifications != null)
                reNotifications.getNotifications(new ArrayList<>());
        }
    }

    /**
     * Get read Notification count
     *
     * @param
     */
    @Deprecated()
    public int getReadNotificationCount() {
        int count = 0;
        try {
            count = new DataBase(appContext).getNotificationCount(true, DataBase.Table.NOTIFICATION_TABLE);
        } catch (Exception e) {

        }

        return count;
    }

    /**
     * Notification wise Delete
     *
     * @param data
     */
    public void deleteNotification(RNotification data) {
        try {
            ExecutorService executor = Executors.newSingleThreadExecutor();
            executor.execute(new Runnable() {
                @Override
                public void run() {
                    try {
                        new DataBase(appContext).deleteNotificationData(data, DataBase.Table.NOTIFICATION_TABLE);
                    } catch (Exception e) {

                    }
                }
            });
        } catch (Exception e) {

        }
    }

    /**
     * Notification wise Delete
     *
     * @param data
     */
    public void deleteNotificationByObject(JSONObject data) {
        try {
            ExecutorService executor = Executors.newSingleThreadExecutor();
            executor.execute(new Runnable() {
                @Override
                public void run() {
                    try {
                        new DataBase(appContext).deleteNotificationByObject(data, DataBase.Table.NOTIFICATION_TABLE);
                    } catch (Exception e) {

                    }
                    //Background work here
                }
            });
        } catch (Exception e) {

        }
    }

    /**
     * Notification wise Delete
     *
     * @param campaignId
     */
    public void deleteNotificationByCampaignId(String campaignId) {
        try {
            ExecutorService executor = Executors.newSingleThreadExecutor();
            executor.execute(new Runnable() {
                @Override
                public void run() {
                    try {
                        new DataBase(appContext).deleteByCampaignId(campaignId, DataBase.Table.NOTIFICATION_TABLE);
                    } catch (Exception e) {

                    }
                    //Background work here

                }
            });
        } catch (Exception e) {

        }

    }

    public void deleteNotificationByNotificationId(String notificationId) {
        try {
            ExecutorService executor = Executors.newSingleThreadExecutor();
            executor.execute(new Runnable() {
                @Override
                public void run() {
                    try {
                        new DataBase(appContext).deleteByNotificationId(notificationId, DataBase.Table.NOTIFICATION_TABLE);
                    } catch (Exception e) {

                    }
                    //Background work here

                }
            });
        } catch (Exception e) {

        }
    }

    /**
     * Campaign & User Notification
     *
     * @return
     */
    @Deprecated
    public ArrayList<RNotification> getNotifications() {
        try {
            return new DataBase(appContext).getDataByModel(DataBase.Table.NOTIFICATION_TABLE);
        } catch (Exception e) {
            ExceptionTracker.track(e);
            return new ArrayList<>();
        }
    }

    @Deprecated
    public ArrayList<JSONObject> getNotificationByObject() {
        try {
            return new DataBase(appContext).getNotification(DataBase.Table.NOTIFICATION_TABLE);
        } catch (Exception e) {
            ExceptionTracker.track(e);
            return new ArrayList<>();
        }
    }

    /**
     * Event type: 1
     *
     * @param eventName
     */
    public void onTrackEvent(String eventName) {
        try {
            AppLifecyclePresenter.getInstance().userEventTracking(appContext, eventName);
            CustomEvents.put(eventName, new JSONObject());
        } catch (Exception e) {

        }

    }

    /**
     * Event type: 2
     *
     * @param data
     * @param eventName
     */
    public void onTrackEvent(JSONObject data, String eventName) {
        try {
            AppLifecyclePresenter.getInstance().userEventTracking(appContext, data, eventName);
            CustomEvents.put(eventName, data);
        } catch (Exception e) {
            ExceptionTracker.track(e);
        }
    }

    /**
     * Event type: 3
     *
     * @param data
     * @param eventName
     */
    public void onTrackEvent(HashMap<String, Object> data, String eventName) {
        try {
            AppLifecyclePresenter.getInstance().userEventTracking(appContext, new JSONObject(data), eventName);
            CustomEvents.put(eventName, new JSONObject(data));
        } catch (Exception e) {
            ExceptionTracker.track(e);
        }
    }

    public void formDataCapture(JSONObject json) {
        HashMap<String, Object> retMap = new HashMap<String, Object>();
        try {
            if (json != JSONObject.NULL) {
                Iterator<String> keysItr = json.keys();
                while (keysItr.hasNext()) {
                    String key = keysItr.next();
                    Object value = json.get(key);
                    retMap.put(key, value);
                }
            }
            formDataCapture(retMap);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void formDataCapture(HashMap<String, Object> data) {
        try {

            if (!data.containsKey("formid")) {
                Toast.makeText(appContext, "Form Id is missing", Toast.LENGTH_SHORT).show();
                return;
            }
            if (TextUtils.isEmpty(data.get("formid").toString())) {
                Toast.makeText(appContext, "Form id value should be empty.", Toast.LENGTH_SHORT).show();
                return;
            }
            if (!data.containsKey("apikey")) {
                Toast.makeText(appContext, "Api key is missing", Toast.LENGTH_SHORT).show();
                return;
            }
            if (TextUtils.isEmpty(data.get("formid").toString())) {
                Toast.makeText(appContext, "Api key value should be empty.", Toast.LENGTH_SHORT).show();
                return;
            }
            data.put("SourceURL", "MobileSDKAndroid");
            data.put("pagereferrerurl", "");
            data.put("rid", SharedPref.getInstance().getStringValue(appContext, AppConstants.PASSPORT_ID));
            data.put("cid", SharedPref.getInstance().getStringValue(appContext, AppConstants.CAMPAIGN_ID));
            data.put("pagetitle", "");
            AppLifecyclePresenter.getInstance().formDataCapture(appContext, new JSONObject(data));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Get smartLink url details : 2
     *
     * @param QRLink
     */
    public void handleQrLink(String QRLink, IGetQRLinkDetail iGetQRLinkDetail) {
        try {
            String shortCodes = QRLink.replace("http://resu.io/", "").replace("https://resu.io/", "").replace("/", "");
            SharedPref.getInstance().setSharedValue(appContext, AppConstants.reSharedCampaignId, shortCodes);
            DataNetworkHandler.getInstance().getCampaignDetails(appContext, null, iGetQRLinkDetail);
            DataNetworkHandler.getInstance().apiCallSmartLink(appContext, QRLink);
        } catch (Exception e) {
            ExceptionTracker.track(e);
        }

    }

    /**
     * SDK App User register
     *
     * @param SDKUserRegister
     */
    private void apiCallRegister(MRegisterUser SDKUserRegister) {
        try {
            ExecutorService executor = Executors.newSingleThreadExecutor();
            Handler handler = new Handler(Looper.getMainLooper());
            executor.execute(() -> {

                try {
                    if (!TextUtils.isEmpty(SDKUserRegister.getUserUniqueId()))
                        SharedPref.getInstance().setSharedValue(appContext, AppConstants.reSharedUserId, SDKUserRegister.getUserUniqueId());
                    else if (!TextUtils.isEmpty(SDKUserRegister.getEmail()))
                        SharedPref.getInstance().setSharedValue(appContext, AppConstants.reSharedUserId, SDKUserRegister.getEmail());
                    else if (!TextUtils.isEmpty(SDKUserRegister.getPhone()))
                        SharedPref.getInstance().setSharedValue(appContext, AppConstants.reSharedUserId, SDKUserRegister.getPhone());

                    String userData = Util.getUserDetails(appContext, SDKUserRegister);
                    //Background work here
                    //UI Thread work here
                    handler.post(() -> {
                        try {
                            DataNetworkHandler.getInstance().apiCallSDKRegistration(appContext, userData);
                        } catch (Exception e) {

                        }
                    });
                } catch (Exception e) {

                }
            });
        } catch (Exception e) {
            ExceptionTracker.track(e);
        }

    }

    private void apiCallGetCapturedField() {
        try {
            DataNetworkHandler.getInstance().apiCallGetCapturedFields(appContext);
        } catch (Exception e) {

        }
    }

    /**
     * SDK App id Validation
     */
    private void apiCallAPIValidation() {
        try {
            new GetDeviceDetails(null).executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR);
            //DataNetworkHandler.getInstance().apiCallAPIKeyValidation(appContext, Util.apiCallAPIValidation(appContext, null));
        } catch (Exception e) {

        }
    }

    public void updatePushToken(String pushToken) {
        try {
            new GetDeviceDetails(pushToken).executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR);
            //DataNetworkHandler.getInstance().apiCallTokenUpdate(appContext, Util.apiCallAPIValidation(appContext, pushToken));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Activity Add LifecycleListener
     *
     * @param context
     */
    private void registerActivityCallBacks(Context context) {

        try {
            if (activityLifecycleCallbacks == null) {
                try {
                    final Application app = (Application) context.getApplicationContext();
                    activityLifecycleCallbacks = new ActivityLifecycleCallbacks();
                    app.registerActivityLifecycleCallbacks(activityLifecycleCallbacks);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        } catch (Exception e) {
            ExceptionTracker.track(e);
        }
    }

    private void schedulePushAmplication(Context context, Bundle bundle) {
        try {
            if (bundle.containsKey("timeDelay")) {
                int duration = bundle.getInt("timeDelay", 1);
                Intent notificationIntent = new Intent(context, ScheduleNotification.class);
                long delay = 0;
                delay = TimeUnit.SECONDS.toMillis(duration);
                notificationIntent.putExtras(bundle);
                PendingIntent pendingIntent = PendingIntent.getBroadcast(context, 1000, notificationIntent, PendingIntent.FLAG_IMMUTABLE | PendingIntent.FLAG_UPDATE_CURRENT);
                Long futureInMillis = SystemClock.elapsedRealtime() + delay;
                AlarmManager alarmManager = (AlarmManager) context.getSystemService(Context.ALARM_SERVICE);

                if (alarmManager != null) {
                    alarmManager.set(AlarmManager.ELAPSED_REALTIME_WAKEUP, futureInMillis, pendingIntent);
                }

            }
        } catch (Exception e) {
            Log.e("scheduleNotification", "" + e.getMessage());
        }
    }

    public int getRandom() {
        long lowerLimit = 123L;
        long upperLimit = 234L;
        Random r = new Random();
        long number = lowerLimit + ((int) (r.nextDouble() * (upperLimit - lowerLimit)));
        return (int) number;
    }

    /**
     * App crash Listener
     */
    private void appCrashHandler(String appID) {

        try {
            if (AppConstants.APP_CRASH) {
                Log.e("App Crash", "Enabled");
                Thread.setDefaultUncaughtExceptionHandler(new Thread.UncaughtExceptionHandler() {
                    @Override
                    public void uncaughtException(Thread thread, Throwable e) {
                        // Get the stack trace.
                        StringWriter sw = new StringWriter();
                        PrintWriter pw = new PrintWriter(sw);
                        e.printStackTrace(pw);
                        Log.e(TAG, "app Crash" + sw.toString());
                        if (AppConstants.CAPP_CRASHED)
                            onTrackEvent("APP CRASHED");

                        new KillThread(sw.toString()).execute();
                    }
                });
            } else {
                Log.e("App Crash", "disabled");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    /**
     * App Exit Listener
     *
     * @param sw
     */
    private void killProcessAndExit(String sw) {
        try {
            activityLifecycleCallbacks.appCrashHandle(sw);
            Thread.sleep(3000);
            android.os.Process.killProcess(android.os.Process.myPid());
            System.exit(10);
        } catch (Exception e1) {
            Util.catchMessage(e1);
        }
    }

    private void socketConnect() {
        try {
            if (!isConnected) {
                Log.e("isConnected", "Called");
                try {
                    mSocket = IO.socket(socketLiveDashboard);
                } catch (URISyntaxException e) {
                    throw new RuntimeException(e);
                }
                mSocket.on(Socket.EVENT_CONNECT, onConnect);
                mSocket.on(appID + "client", onMessage);
                mSocket.on(Socket.EVENT_CONNECT_ERROR, onError);
                mSocket.on(Socket.EVENT_DISCONNECT, onDisconnect);
                mSocket.connect();
            }
        } catch (Exception e) {
            ExceptionTracker.track(e);
        }
    }

    private void emitNewUser(String activityName, String fragmentName) {
        try {
            if (isConnected) {
                String val = SharedPref.getInstance().getStringValue(appContext, AppConstants.reSharedUserId);
                String userId = "";
                userId = new String(Base64.encode(val.getBytes(), Base64.DEFAULT));
                JSONObject jobj = new JSONObject();
                jobj.put("appId", appID);
                jobj.put("deviceId", Util.getDeviceId(appContext));
                jobj.put("deviceName", Build.DEVICE);
                jobj.put("deviceModel", Build.MODEL);
                jobj.put("deviceType", Util.getDeviceType(appContext));
                jobj.put("userId", userId);
                jobj.put("deviceManufacture", Build.MANUFACTURER);
                jobj.put("activityName", activityName);
                jobj.put("fragmentName", fragmentName);
                mSocket.emit("NewAppUser", jobj);
                Log.e("new User ", "Emitted");
            } else {
                // socketConnect();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void getLastVisit(Context activity) {
        try {
            String val = SharedPref.getInstance().getStringValue(appContext, AppConstants.reSharedUserId);
            String userId = "";
            String deviceAppMapID = SharedPref.getInstance().getStringValue(activity, "deviceAppMapID");
            String passportID = SharedPref.getInstance().getStringValue(activity, AppConstants.PASSPORT_ID);

            userId = new String(Base64.encode(val.getBytes(), Base64.DEFAULT));
            JSONObject jsonObject = new JSONObject();

            if (TextUtils.isEmpty(passportID))
                passportID = Util.getDeviceId(activity);

            if (TextUtils.isEmpty(deviceAppMapID))
                passportID = Util.getDeviceId(activity);

            jsonObject.put("id", deviceAppMapID + passportID);

            if (!TextUtils.isEmpty(userId)) {
                new DataNetworkHandler().apiCallGetLastVisit(activity, jsonObject);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void getMobileConfig() {

        try {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("appId", appID);
            new DataNetworkHandler().apiGetConfig(appContext, jsonObject);
        } catch (Exception e) {
            e.printStackTrace();

        }

    }

    private void getReferrelData() {
        try {
            // Connection established.
            boolean flag = SharedPref.getInstance().getBooleanValue(appContext, "appFisrtOpen");
            if (!flag) {
                final InstallReferrerClient referrerClient = InstallReferrerClient.newBuilder(appContext).build();
                referrerClient.startConnection(new InstallReferrerStateListener() {
                    @Override
                    public void onInstallReferrerSetupFinished(int responseCode) {

                        switch (responseCode) {

                            case InstallReferrerClient.InstallReferrerResponse.OK:
                                // Connection established.
                                try {
                                    JSONObject referrerObject = new JSONObject();
                                    SharedPref.getInstance().setSharedValue(appContext, "appFisrtOpen", true);
                                    ReferrerDetails response = referrerClient.getInstallReferrer();
                                    String rawReferrerString = response.getInstallReferrer();
                                    Log.e("referrerUrlSDK", rawReferrerString);

                                    if (rawReferrerString != null) {
                                        try {
                                            referrerObject.put(AppConstants.reApiParamIsNewUser, true);
                                            referrerObject.put(AppConstants.reDeepLinkParamIsViaDeepLinkingLauncher, true);
                                            rawReferrerString = URLDecoder.decode(rawReferrerString, "UTF-8");
                                            String[] referralParams = rawReferrerString.split("&");
                                            for (String referrerParam : referralParams) {
                                                String[] keyValue = referrerParam.split("=");
                                                if (keyValue.length > 1) {
                                                    referrerObject.put(URLDecoder.decode(keyValue[0], "UTF-8"), URLDecoder.decode(keyValue[1], "UTF-8"));
                                                }
                                            }
                                            SharedPref.getInstance().setSharedValue(appContext, AppConstants.reApiParamIsNewUser, true);

                                            if (referrerObject.has(AppConstants.reDeepLinkParamReferralId) || referrerObject.has(AppConstants.sdkDeepLinkParamReferralId)) {
                                                String value = referrerObject.optString(AppConstants.reDeepLinkParamReferralId, "");
                                                if (TextUtils.isEmpty(value)) {
                                                    value = referrerObject.optString(AppConstants.sdkDeepLinkParamReferralId, "");
                                                }
                                                getSmartLinkDetails(appContext, value);
                                                SharedPref.getInstance().setSharedValue(appContext, AppConstants.reSharedCampaignId, value);

                                            }
                                        } catch (Exception e) {
                                            e.printStackTrace();
                                        }
                                    }
                                    referrerClient.endConnection();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                                break;
                            case InstallReferrerClient.InstallReferrerResponse.FEATURE_NOT_SUPPORTED:
                                // API not available on the current Play Store app.
                                break;
                            case InstallReferrerClient.InstallReferrerResponse.SERVICE_UNAVAILABLE:
                                // Connection couldn't be established.
                                break;
                        }
                    }

                    @Override
                    public void onInstallReferrerServiceDisconnected() {

                    }
                });

            }

            boolean flags = SharedPref.getInstance().getBooleanValue(appContext, "appFirstOpen");
            if (AppConstants.CFIRST_APP_OPEN && Util.ruleAppInstalled(appContext)) {
                if (!flags) {
                    onTrackEvent("App first open");
                    SharedPref.getInstance().setSharedValue(appContext, "appFirstOpen", true);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    void getSmartLinkDetails(final Context activity, String smartLink) {
        try {

            IGetQRLinkDetail iGetQRLinkDetail = new IGetQRLinkDetail() {
                @Override
                public void onSmartLinkDetails(String Data) {
                    try {
                        JSONObject jsonObject = new JSONObject(Data);
                        SharedPref.getInstance().setSharedValue(activity, AppConstants.reSharedMobileFriendlyUrl, jsonObject.getString("MobileFriendlyUrl"));
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }

                @Override
                public void onError(String error) {

                }
            };

            try {
                String shortCodes = smartLink.replace("http://resu.io/", "").replace("https://resu.io/", "").replace("/", "");
                SharedPref.getInstance().setSharedValue(activity, AppConstants.reSharedCampaignId, shortCodes);
                DataNetworkHandler.getInstance().getCampaignDetails(activity, null, iGetQRLinkDetail);
                new DataNetworkHandler().apiCallSmartLink(activity, smartLink);
            } catch (Exception e) {
                ExceptionTracker.track(e);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    static class GetNotifications /*extends AsyncTask<String, String, String>*/ {
        IRNotifications reNotifications;
        Boolean isByObject;
        int count = 0;
        ArrayList<JSONObject> jsonObjects = new ArrayList<>();
        ArrayList<RNotification> rNotifications = new ArrayList<>();

        GetNotifications(IRNotifications reNotifications, Boolean isByObject) {
            this.reNotifications = reNotifications;
            this.isByObject = isByObject;
        }

        void executeOnExecutor(Executor executors, String obj) {
            try {
                ExecutorService executor = Executors.newSingleThreadExecutor();
                Handler handler = new Handler(Looper.getMainLooper());
                executor.execute(() -> {
                    try {
                        String s = doInBackground();
                        //Background work here
                        //UI Thread work here
                        handler.post(() -> {
                            //UI Thread work here
                            try {
                                onPostExecute(s);
                            } catch (Exception e) {

                            }
                        });
                    } catch (Exception e) {

                    }
                });
            } catch (Exception e) {

            }
        }

        void execute() {
            try {
                ExecutorService executor = Executors.newSingleThreadExecutor();
                Handler handler = new Handler(Looper.getMainLooper());
                executor.execute(() -> {
                    try {
                        String s = doInBackground();
                        //Background work here
                        //UI Thread work here
                        handler.post(() -> {
                            //UI Thread work here
                            try {
                                onPostExecute(s);
                            } catch (Exception e) {

                            }
                        });
                    } catch (Exception e) {

                    }
                });
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        private String doInBackground(String... urls) {
            try {
                if (isByObject) {
                    jsonObjects = new DataBase(appContext).getNotification(DataBase.Table.NOTIFICATION_TABLE);
                } else {
                    rNotifications = new DataBase(appContext).getDataByModel(DataBase.Table.NOTIFICATION_TABLE);
                }
            } catch (Exception e) {

            }
            return "";
        }

        private void onPostExecute(String result) {
            try {
                if (reNotifications != null) {
                    if (isByObject)
                        reNotifications.getNotificationByObject(jsonObjects);
                    else
                        reNotifications.getNotifications(rNotifications);

                }
            } catch (Exception e) {

            }
        }
    }

    static class getCount /*extends AsyncTask<String, String, String>*/ {
        IRNotifications reNotifications;
        Boolean flag;
        int count = 0;

        getCount(IRNotifications reNotifications, Boolean flag) {
            this.reNotifications = reNotifications;
            this.flag = flag;
        }

        void executeOnExecutor(Executor executors, String obj) {
            try {
                ExecutorService executor = Executors.newSingleThreadExecutor();
                Handler handler = new Handler(Looper.getMainLooper());
                executor.execute(() -> {
                    try {
                        String s = doInBackground();
                        //Background work here
                        //UI Thread work here
                        handler.post(() -> {
                            //UI Thread work here
                            try {
                                onPostExecute(s);
                            } catch (Exception e) {

                            }
                        });
                    } catch (Exception e) {

                    }
                });
            } catch (Exception e) {

            }
        }

        void execute() {
            try {
                ExecutorService executor = Executors.newSingleThreadExecutor();
                Handler handler = new Handler(Looper.getMainLooper());
                executor.execute(() -> {
                    try {
                        String s = doInBackground();
                        //Background work here
                        //UI Thread work here
                        handler.post(() -> {
                            //UI Thread work here
                            try {
                                onPostExecute(s);
                            } catch (Exception e) {

                            }
                        });
                    } catch (Exception e) {

                    }
                });
            } catch (Exception e) {

            }
        }

        private String doInBackground(String... urls) {
            try {
                count = new DataBase(appContext).getNotificationCount(flag, DataBase.Table.NOTIFICATION_TABLE);
            } catch (Exception e) {

            }
            return "";
        }

        private void onPostExecute(String result) {
            try {
                if (reNotifications != null) {
                    if (flag)
                        reNotifications.getReadCount(count);
                    else
                        reNotifications.getUnreadCount(count);
                }
            } catch (Exception e) {

            }
        }
    }

    private class KillThread {

        String log;

        KillThread(String log) {
            this.log = log;
        }

        void execute() {
            try {
                ExecutorService executor = Executors.newSingleThreadExecutor();
                executor.execute(() -> {
                    try {
                        String s = doInBackground();
                    } catch (Exception e) {

                    }
                });
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        protected String doInBackground(String... urls) {
            try {
                killProcessAndExit(log);
            } catch (Exception e) {

            }
            return "";
        }

    }

    private class getAppID /* extends AsyncTask<String, String, String>*/ {

        Context context;

        getAppID(Context context) {
            this.context = context;
        }

        void execute() {
            try {
                ExecutorService executor = Executors.newSingleThreadExecutor();
                Handler handler = new Handler(Looper.getMainLooper());
                executor.execute(() -> {
                    try {
                        String s = doInBackground();
                        //Background work here
                        //UI Thread work here
                        handler.post(() -> {
                            //UI Thread work here
                            try {
                                onPostExecute(s);
                            } catch (Exception e) {

                            }
                        });
                    } catch (Exception e) {

                    }
                });
            } catch (Exception e) {

            }
        }

        private String doInBackground(String... urls) {
            try {
                AppConstants.LogFlag = SharedPref.getInstance().getBooleanValue(context, "logFlag");
                int visitorCount = SharedPref.getInstance().getIntValue(context, "visitorCount");
                visitorCount++;
                Log.e("Visitor Count", "" + visitorCount);
                SharedPref.getInstance().setSharedValue(context, "visitorCount", visitorCount);
                appID = Util.getAppKey(context);
                Util.getScreenResolution(context.getApplicationContext());
                SharedPref.getInstance().setSharedValue(context, AppConstants.reSharedDatabaseDeviceId, Util.getDeviceId(context));
                sessionId = Util.getDeviceId(context) + "_" + System.currentTimeMillis();
            } catch (Exception e) {

            }
            return "";
        }

        private void onPostExecute(String s) {
            try {
                new Util().setConfig(context);
                appCrashHandler(appID);
                getMobileConfig();
                GetAppInfo(context);
                apiCallAPIValidation();
                new OfflineCampaignTrack(context, null, AppConstants.NOTIFICATION_OPEN, "Opened", false, null, null, DataNetworkHandler.getInstance()).execute();
                if (AppConstants.APP_LIVE_DASHBOARD)
                    socketConnect();
                onDBCheck(context);
                apiCallGetCapturedField();

            } catch (Exception e) {

            }
        }
    }

    private class InstallReferrer /*extends AsyncTask<String, String, String>*/ {

        void executeOnExecutor(Context context) {
            try {
                ExecutorService executor = Executors.newSingleThreadExecutor();
                Handler handler = new Handler(Looper.getMainLooper());
                executor.execute(() -> {
                    try {
                        String s = doInBackground();
                        //Background work here
                        //UI Thread work here
                        handler.post(() -> {
                            //UI Thread work here
                            try {
                                String val = SharedPref.getInstance().getStringValue(context, "sdkreg");
                                new DataNetworkHandler().apiCallGetSDKRules(context);
                                AppRuleListener.getInstance().findingRules();
                                if (AppConstants.NOTIFICATION_DND_DISABLED || NotificationManagerCompat.from(appContext).areNotificationsEnabled()) {
                                    new DataNetworkHandler().apiCallGetPushAmplification(context);
                                }
                            } catch (Exception e) {
                            }

                        });
                    } catch (Exception e) {

                    }
                });
            } catch (Exception e) {

            }
        }


        protected String doInBackground(String... urls) {
            try {
                appOpenTime = Util.getNotificationCurrentUTC();
                Log.e("appOpenTime", "" + appOpenTime);
                getReferrelData();
            } catch (Exception e) {

            }
            return "";
        }

    }

    private class GetDeviceDetails /*extends AsyncTask<String, String, String>*/ {

        String token;

        GetDeviceDetails(String token) {
            this.token = token;
        }

        void executeOnExecutor(Executor executors) {
            try {
                ExecutorService executor = Executors.newSingleThreadExecutor();
                Handler handler = new Handler(Looper.getMainLooper());
                executor.execute(() -> {
                    try {
                        String s = doInBackground();
                        //Background work here
                        //UI Thread work here
                        handler.post(() -> {
                            //UI Thread work here
                            try {
                                onPostExecute(s);
                            } catch (Exception e) {

                            }
                        });
                    } catch (Exception e) {

                    }
                });
            } catch (Exception e) {

            }
        }

        void execute() {
            try {
                ExecutorService executor = Executors.newSingleThreadExecutor();
                Handler handler = new Handler(Looper.getMainLooper());
                executor.execute(() -> {
                    try {
                        String s = doInBackground();
                        //Background work here
                        //UI Thread work here
                        handler.post(() -> {
                            //UI Thread work here
                            try {
                                onPostExecute(s);
                            } catch (Exception e) {

                            }
                        });
                    } catch (Exception e) {

                    }
                });
            } catch (Exception e) {

            }
        }

        private String doInBackground(String... urls) {
            return new Util().apiCallAPIValidation(appContext, token);
        }

        private void onPostExecute(String result) {
            try {
                if (!TextUtils.isEmpty(result)) {
                    if (token == null)
                        DataNetworkHandler.getInstance().apiCallAPIKeyValidation(appContext, result);
                    else
                        DataNetworkHandler.getInstance().apiCallTokenUpdate(appContext, result);

                }
            } catch (Exception e) {

            }

        }
    }

    private Emitter.Listener onError = new Emitter.Listener() {
        @Override
        public void call(Object... args) {
            try {
                retrycout = retrycout + 1;
                if (retrycout > 3) {
                    mSocket.disconnect();
                    mSocket.off(Socket.EVENT_CONNECT, onConnect);
                    mSocket.off(appID + "client", onMessage);
                    mSocket.off(Socket.EVENT_DISCONNECT, onDisconnect);
                    mSocket.off(Socket.EVENT_CONNECT_ERROR, onError);
                }
                Log.e("onError", "called");
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
    };


    /**
     * Socket onDisconnect
     */
    private Emitter.Listener onDisconnect = new Emitter.Listener() {
        @Override
        public void call(Object... args) {
            try {
                isConnected = false;
                mSocket.off(Socket.EVENT_CONNECT, onConnect);
                mSocket.off(appID + "client", onMessage);
                mSocket.off(Socket.EVENT_CONNECT_ERROR, onError);
                mSocket.off(Socket.EVENT_DISCONNECT, onDisconnect);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    };


}

/**
 * ****************************************
 */

/**
 *
 */




