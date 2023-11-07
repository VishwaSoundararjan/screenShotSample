package io.mob.resu.reandroidsdk;

import static io.mob.resu.reandroidsdk.AppConstants.APP_CURRENT_EVENT;
import static io.mob.resu.reandroidsdk.AppConstants.CURRENT_ACTIVITY_NAME;
import static io.mob.resu.reandroidsdk.AppConstants.CURRENT_FRAGMENT_NAME;
import static io.mob.resu.reandroidsdk.AppConstants.CustomEvents;
import static io.mob.resu.reandroidsdk.AppConstants.CustomEventsData;
import static io.mob.resu.reandroidsdk.AppConstants.LAST_APP_OPENED;
import static io.mob.resu.reandroidsdk.AppConstants.appOpenTime;
import static io.mob.resu.reandroidsdk.AppConstants.pageStartTime;
import static io.mob.resu.reandroidsdk.AppConstants.screenViews;

import android.content.Context;
import android.content.res.Configuration;
import android.location.Address;
import android.location.Geocoder;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import android.text.TextUtils;

import androidx.core.app.NotificationManagerCompat;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.concurrent.Executor;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import io.mob.resu.reandroidsdk.error.ExceptionTracker;
import io.mob.resu.reandroidsdk.error.Log;

public class AppRuleListener {

    public static String LAST_FRAGMENT_NAME = "";
    public static ArrayList<String> sessionRules = new ArrayList<>();
    public static ArrayList<String> entryRules = new ArrayList<>();
    public static ArrayList<String> sessionDurationRules = new ArrayList<>();
    static AppRuleListener appRuleListener;
    static Context context;
    private final String NEW_VISITOR = "new visitors";
    private final String RETURN_VISITOR = "returning visitors";
    private final String APP_INSTALL = "app install";
    private final String APP_INSTALLED_DATE = "app installed date";
    private final String APP_UPDATED = "app updated";
    private final String APP_UPDATED_DATE = "app updated date";
    private final String APP_OPENED = "app opened";
    private final String APP_OPENED_DATE = "app opened date";
    private final String APP_CLOSE = "app close";
    private final String APP_CLOSED = "app closed";
    private final String APP_CLOSED_DATE = "app closed date";
    private final String APP_VERSION_CODE = "app version code";
    private final String APP_VERSION_NAME = "app version name";
    private final String APP_CUSTOM_EVENTS = "custom events";
    private final String APP_DEVICE_TYPE = "device type";
    private final String APP_LANGUAGE = "language";
    private final String APP_LAST_VISITED_SCREEN = "last visited screen";
    private final String APP_LOCATION = "location";
    private final String APP_NOTIFICATION_DISABLED = "notification disabled";
    private final String APP_OS = "operating systems";
    private final String APP_SCREEN_VIEWS = "screen views";
    private final String APP_TIME_SPEND_ON_SCREEN = "time spent on screen";
    private final String APP_USER_TYPE = "user type";
    private final String DEVICE_OS_VERSION = "version";
    private final String APP_SESSION_DURATION = "session duration";
    private final String APP_IN_BACKGROUND = "app in background";
    private final String APP_USER_VIEW_SPECIFIC_SCREEN = "when a user views a specific screen";
    private final String DEVICE_OS = "Android";
    private final String LOGIN = "login";
    boolean appClose = false;
    boolean appUserLogin = false;
    ArrayList<String> campaignBlastedId = new ArrayList<>();
    ArrayList<JSONObject> entryLevelRules = new ArrayList<>();
    ArrayList<JSONObject> sessionLevelRules = new ArrayList<>();
    ArrayList<JSONObject> customEventLevelRules = new ArrayList<>();
    ArrayList<JSONObject> userTypeLevelRules = new ArrayList<>();
    ArrayList<JSONObject> locationLevelRules = new ArrayList<>();
    ArrayList<JSONObject> exitLevelRules = new ArrayList<>();
    ArrayList<JSONObject> appInBackgroundLevelRules = new ArrayList<>();
    String values = "";
    private String tenantID = "";

    public static AppRuleListener getInstance() {
        try {
            if (appRuleListener == null) {
                appRuleListener = new AppRuleListener();
            }
            return appRuleListener;
        } catch (Exception e) {
            return new AppRuleListener();
        }
    }

    public void findingRules() {
        try {
            // getRules();
            new RuleFinding().execute();
        } catch (Exception e) {

        }

    }


    public void Init(Context context) {
        this.context = context;
        try {
            processEntryRules(context);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    // every Time app opens
    public void processEntryRules(Context context) {
        this.context = context;
        try {
            //ArrayList<JSONObject> entryRules = getRules("entry");
            Log.e("Rules entryRules size", "" + entryLevelRules.size());
            ArrayList<JSONObject> entryRule = new ArrayList<>();
            if (entryLevelRules != null) {

                if (entryLevelRules.size() > 0) {
                    for (int i = 0; i < entryLevelRules.size(); i++) {
                        String listId = entryLevelRules.get(i).getString("dynamicListId");

                        if (!entryRules.contains(listId)) {
                            entryRule.add(entryLevelRules.get(i));
                        } else {
                            entryLevelRules.remove(i);
                        }
                    }
                    new RulesEngine(entryRule).executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR);
                }
                //  processRules(entryLevelRules);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Session time interval meets
    public void processSessionRules(Context context, String timeDelay) {
        this.context = context;
        try {
            //ArrayList<JSONObject> sessionRules = getRules("session");
            Log.e("Rules session size", "" + sessionLevelRules.size());
            ArrayList<JSONObject> sessionRules = sessionLevelRules;
            if (sessionRules != null) {
                //processRules(sessionRules);
                if (sessionRules.size() > 0) {
                    new RulesEngine(sessionRules).executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // After user register success
    public void processUserTypeChangeRules(Context context) {
        this.context = context;
        try {
            appUserLogin = true;
            Log.e("Rules userType size", "" + userTypeLevelRules.size());
            //ArrayList<JSONObject> userTypeRules = getRules("usertype");
            ArrayList<JSONObject> userTypeRules = new ArrayList<>();
            if (userTypeLevelRules != null) {
                if (userTypeLevelRules.size() > 0) {
                    for (int i = 0; i < userTypeLevelRules.size(); i++) {
                        String listId = userTypeLevelRules.get(i).getString("dynamicListId");
                        if (!entryRules.contains(listId)) {
                            userTypeRules.add(userTypeLevelRules.get(i));
                        } else {
                            userTypeLevelRules.remove(i);
                        }
                    }
                    //processRules(userTypeLevelRules);
                    new RulesEngine(userTypeRules).executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR);
                }

            }


        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Every custom event happen
    void processCustomEventRules(Context context, JSONObject data, String eventName) {
        this.context = context;
        try {
            Log.e("Rules CustomEventRules size", "" + customEventLevelRules.size());

            APP_CURRENT_EVENT = eventName;
            SharedPref.getInstance().setSharedValue(context, "CurrentEventName", eventName);
            // ArrayList<JSONObject> eventRules = getRules("customevent");
            ArrayList<JSONObject> eventRules = customEventLevelRules;
            if (eventRules != null) {
                Log.e("Rules CustomEventRules size", "" + eventRules.size());
                // processRules(eventRules);
                if (eventRules.size() > 0)
                    new RulesEngine(eventRules).executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // location Change
    void processLocationRules(Context context, double latitude, double longitude) {
        this.context = context;
        try {
            SharedPref.getInstance().setSharedValue(context, "latitude", "" + latitude);
            SharedPref.getInstance().setSharedValue(context, "longitude", "" + longitude);
            getLocationFromAddress(context, latitude, longitude);
            Log.e("Rules locationRules size", "" + locationLevelRules.size());
            // ArrayList<JSONObject> locationRules = getRules("location");
            ArrayList<JSONObject> locationRules = locationLevelRules;
            if (locationRules != null) {
                //  processRules(locationRules);
                if (locationRules.size() > 0)
                    new RulesEngine(locationRules).executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // app exit
    void processExit(Context context) {
        this.context = context;
        appClose = true;
        try {
            // ArrayList<JSONObject> exitRules = getRules("closed");
            Log.e("Rules exitRules size", "" + exitLevelRules.size());
            ArrayList<JSONObject> exitRules = exitLevelRules;
            if (exitRules != null) {

                //  processRules(exitRules);
                if (exitRules.size() > 0)
                    new RulesEngine(exitRules).executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // app in background
    void processAppInBackground(Context context) {
        this.context = context;
        try {
            //ArrayList<JSONObject> appinbackground = getRules("appinbackground");
            Log.e("Rules appinbackground size", "" + appInBackgroundLevelRules.size());
            ArrayList<JSONObject> appinbackground = appInBackgroundLevelRules;
            if (appinbackground != null) {
                //processRules(appinbackground);
                if (appinbackground.size() > 0)
                    new RulesEngine(appinbackground, true).executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private ArrayList<JSONObject> getRules() {
        try {
            entryLevelRules = new ArrayList<>();
            sessionLevelRules = new ArrayList<>();
            customEventLevelRules = new ArrayList<>();
            userTypeLevelRules = new ArrayList<>();
            locationLevelRules = new ArrayList<>();
            exitLevelRules = new ArrayList<>();
            appInBackgroundLevelRules = new ArrayList<>();
            String value = SharedPref.getInstance().getStringValue(context, "localRules");
            //value = values;
            Log.e("Rules", value);
            if (TextUtils.isEmpty(value)) {
                return new ArrayList<>();
            }

            JSONObject jsonObject = new JSONObject(value);
            JSONArray dynamicList = jsonObject.optJSONArray("dynamiclist");
            tenantID = jsonObject.getString("tenantID").replace("cust_", "camp_");
            if (dynamicList != null) {

                for (int i = 0; i < dynamicList.length(); i++) {
                    JSONArray rules = dynamicList.getJSONObject(i).optJSONArray("rules");
                    String rule = rules.toString().toLowerCase();
                    String dynamicListId = dynamicList.getJSONObject(i).getString("dynamicListId");
                    String campaignID = dynamicList.getJSONObject(i).getString("campaignId");
                    String blastedCampaignKey = dynamicListId + campaignID;
                    String alreadyBlasted = SharedPref.getInstance().getStringValue(context, blastedCampaignKey);
                    // Entry rule filter
                    if (!rule.contains(LOGIN) && !rule.contains(APP_SESSION_DURATION) && !rule.contains(APP_USER_VIEW_SPECIFIC_SCREEN) && !rule.contains(APP_LOCATION) && !rule.contains(APP_CUSTOM_EVENTS) && !rule.contains(APP_TIME_SPEND_ON_SCREEN) && !rule.contains(APP_LAST_VISITED_SCREEN) && !rule.contains(APP_SCREEN_VIEWS) && !rule.contains(APP_IN_BACKGROUND) && !rule.contains(APP_CLOSED + "\"")) {
                        if (!blastedCampaignKey.equalsIgnoreCase(alreadyBlasted) || dynamicList.getJSONObject(i).getBoolean("isFrequencyEnabled")) {

                            if (rule.contains(APP_OPENED + "\"") || rule.contains(APP_UPDATED + "\"") || !blastedCampaignKey.equalsIgnoreCase(alreadyBlasted)) {
                                entryLevelRules.add(dynamicList.getJSONObject(i));
                            } else {
                                Log.e("This entry rule multi time not allowed", dynamicList.getJSONObject(i).getString("dynamicListName"));
                            }
                        } else {
                            Log.e("This Rule single time already blasted", dynamicList.getJSONObject(i).getString("dynamicListName"));
                        }

                    }
                    // Session rule filter
                    if (rule.contains(APP_SESSION_DURATION) || rule.contains(APP_USER_VIEW_SPECIFIC_SCREEN) || rule.contains(APP_LAST_VISITED_SCREEN) || rule.contains(APP_TIME_SPEND_ON_SCREEN) || rule.contains(APP_SCREEN_VIEWS)) {

                        if (!blastedCampaignKey.equalsIgnoreCase(alreadyBlasted) || dynamicList.getJSONObject(i).getBoolean("isFrequencyEnabled")) {
                            sessionLevelRules.add(dynamicList.getJSONObject(i));
                        }
                    }
                    // User Type rule filter
                    if (rule.contains(APP_USER_TYPE) || rule.contains(LOGIN)) {
                        if (!blastedCampaignKey.equalsIgnoreCase(alreadyBlasted) || dynamicList.getJSONObject(i).getBoolean("isFrequencyEnabled")) {
                            userTypeLevelRules.add(dynamicList.getJSONObject(i));
                        }
                    }
                    // Custom Event rule filter
                    if (rule.contains(APP_CUSTOM_EVENTS)) {
                        if (!blastedCampaignKey.equalsIgnoreCase(alreadyBlasted) || dynamicList.getJSONObject(i).getBoolean("isFrequencyEnabled")) {
                            customEventLevelRules.add(dynamicList.getJSONObject(i));
                        }
                    }
                    // Location rule filter
                    if (rule.contains(APP_LOCATION)) {
                        if (!blastedCampaignKey.equalsIgnoreCase(alreadyBlasted) || dynamicList.getJSONObject(i).getBoolean("isFrequencyEnabled")) {
                            locationLevelRules.add(dynamicList.getJSONObject(i));
                        }
                    }
                    // Closed rule filter
                    if (rule.contains(APP_CLOSED)) {
                        if (!blastedCampaignKey.equalsIgnoreCase(alreadyBlasted) || dynamicList.getJSONObject(i).getBoolean("isFrequencyEnabled")) {
                            exitLevelRules.add(dynamicList.getJSONObject(i));
                        }
                    }
                    // App in background
                    if (rule.contains(APP_IN_BACKGROUND)) {
                        if (!blastedCampaignKey.equalsIgnoreCase(alreadyBlasted) || dynamicList.getJSONObject(i).getBoolean("isFrequencyEnabled")) {
                            appInBackgroundLevelRules.add(dynamicList.getJSONObject(i));
                        }
                    }
                }
            }
            Log.e("11-Entry Rule count : ", "" + entryLevelRules.size());
            Log.e("11-Session Rule count : ", "" + sessionLevelRules.size());
            Log.e("11-Custom Rule count : ", "" + customEventLevelRules.size());
            Log.e("11-UserType Rule count : ", "" + userTypeLevelRules.size());
            Log.e("11-Location Rule count : ", "" + locationLevelRules.size());
            Log.e("11-Exit Rule count : ", "" + exitLevelRules.size());
            Log.e("11-App in back Rule count : ", "" + appInBackgroundLevelRules.size());
            return new ArrayList<>();
        } catch (
                Exception e) {
            e.printStackTrace();
        }
        return new ArrayList<>();
    }

    private ArrayList<JSONObject> processRules(ArrayList<JSONObject> ruleList) {
        ArrayList<JSONObject> blastingCampaign = new ArrayList<>();
        try {
            if (ruleList.size() > 0) {
                for (int i = 0; i < ruleList.size(); i++) {
                    JSONArray rules = ruleList.get(i).getJSONArray("rules");
                    Log.e("Rules ******Started****", ruleList.get(i).getString("dynamicListName"));
                    String rule = ruleList.get(i).toString().toLowerCase();

                    if (oneTimeLimitation(ruleList.get(i))) {
                        String dynamicListId = ruleList.get(i).getString("dynamicListId");
                        String campaignID = ruleList.get(i).getString("campaignId");
                        String blastedCampaignKey = dynamicListId + campaignID;
                        if (!SharedPref.getInstance().getStringValue(context, blastedCampaignKey).contains(blastedCampaignKey) || ruleList.get(i).getBoolean("isFrequencyEnabled")) {
                            if (!sessionRules.contains(ruleList.get(i).getString("dynamicListId"))) {
                                if (ruleList.get(i).getString("ruleType").toLowerCase().contains("all")) {
                                    boolean value = ruleEngineAll(rules, campaignID);
                                    Log.e("Rules *****END*****", ruleList.get(i).getString("dynamicListName"));
                                    if (value) {
                                        entryRules.add(ruleList.get(i).getString("dynamicListId"));
                                        if (rule.contains(APP_SESSION_DURATION.toLowerCase()) || rule.contains(APP_USER_VIEW_SPECIFIC_SCREEN.toLowerCase()) || rule.contains(APP_LAST_VISITED_SCREEN.toLowerCase()) || rule.contains(APP_TIME_SPEND_ON_SCREEN.toLowerCase()) || rule.contains(APP_SCREEN_VIEWS.toLowerCase())) {
                                            sessionDurationRules.add(ruleList.get(i).getString("dynamicListId"));
                                            sessionRules.add(ruleList.get(i).getString("dynamicListId"));
                                            campaignBlastedId.add(dynamicListId + campaignID);
                                            // triggerBlast(ruleList.get(i));
                                            blastingCampaign.add(ruleList.get(i));
                                            // return ruleList.get(i);
                                            // }
                                        } else {
                                            // return ruleList.get(i);
                                            blastingCampaign.add(ruleList.get(i));
                                            // triggerBlast(ruleList.get(i));
                                        }
                                    }
                                } else {
                                    boolean value = ruleEngineAny(rules, campaignID) >= ruleList.get(i).getInt("anyCount");
                                    Log.e("Rules *****END*****", ruleList.get(i).getString("dynamicListName"));
                                    if (value) {
                                        // Toast.makeText(context, "Any Rule Blasted", Toast.LENGTH_SHORT).show();
                                        entryRules.add(ruleList.get(i).getString("dynamicListId"));
                                        if (rule.contains(APP_SESSION_DURATION.toLowerCase()) || rule.contains(APP_USER_VIEW_SPECIFIC_SCREEN.toLowerCase()) || rule.contains(APP_LAST_VISITED_SCREEN.toLowerCase()) || rule.contains(APP_TIME_SPEND_ON_SCREEN.toLowerCase()) || rule.contains(APP_SCREEN_VIEWS.toLowerCase())) {
                                            sessionDurationRules.add(ruleList.get(i).getString("dynamicListId"));
                                            sessionRules.add(ruleList.get(i).getString("dynamicListId"));
                                            campaignBlastedId.add(dynamicListId + campaignID);
                                            //triggerBlast(ruleList.get(i));
                                            blastingCampaign.add(ruleList.get(i));
                                            // return ruleList.get(i);
                                            // }
                                        } else {
                                            // return ruleList.get(i);
                                            blastingCampaign.add(ruleList.get(i));
                                            // triggerBlast(ruleList.get(i));
                                        }
                                    }
                                }
                            } else {
                                Log.e("Session Control rules ", "Already blasted");
                                Log.e("Rules *****END*****", ruleList.get(i).getString("dynamicListName"));
                            }
                        } else {
                            Log.e("Single time blast rules ", "Already blasted");
                            Log.e("Rules *****END*****", ruleList.get(i).getString("dynamicListName"));
                        }
                    } else {
                        Log.e("The SINGLE rule restriction ", "Already blasted");
                        Log.e("Rules *****END*****", ruleList.get(i).getString("dynamicListName"));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return blastingCampaign;
    }

    private void storeLocation() {
        try {

            String listID = "";
            //jsonObject.getString("dynamicListId");
            String keyCity = "Location_" + listID + "city";
            String keyState = "Location_" + listID + "state";
            String keyCountry = "Location_" + listID + "country";
            SharedPref.getInstance().setSharedValue(context, keyCity, getCurrentCityName());
            SharedPref.getInstance().setSharedValue(context, keyState, getCurrentStateName());
            SharedPref.getInstance().setSharedValue(context, keyCountry, getCurrentCountryName());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void appUpdate() {
        try {
            String appUpdateDate = "AppUpdateDate";
            SharedPref.getInstance().setSharedValue(context, appUpdateDate, Util.getAppUpdateTime(context));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private boolean appUpdateValidation() {
        try {
            String appUpdateDate = SharedPref.getInstance().getStringValue(context, "AppUpdateDate");
            SharedPref.getInstance().setSharedValue(context, appUpdateDate, Util.getAppUpdateTime(context));
            if (appUpdateDate.equalsIgnoreCase(Util.getAppUpdateTime(context))) {
                return false;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return true;

    }


    private boolean LastBlastedLocation(JSONObject rule) {
        try {

            String listID = "";
            rule.getString("dynamicListId");
            JSONArray jsonArray = rule.getJSONArray("rules");
            String location = jsonArray.getJSONObject(0).getString("value").toLowerCase();
            String keyCity = "Location_" + listID + "city";
            String keyState = "Location_" + listID + "state";
            String keyCountry = "Location_" + listID + "country";
            String city = SharedPref.getInstance().getStringValue(context, keyCity).toLowerCase();
            String state = SharedPref.getInstance().getStringValue(context, keyState).toLowerCase();
            String country = SharedPref.getInstance().getStringValue(context, keyCountry).toLowerCase();
            String CurrentCity = getCurrentCityName().toLowerCase();
            String CurrentState = getCurrentStateName().toLowerCase();


            if (!city.contains(getCurrentCityName().toLowerCase()) || !state.contains(getCurrentStateName().toLowerCase())) {
                return false;
            }


        } catch (Exception e) {
            e.printStackTrace();
        }
        return true;

    }


    private boolean oneTimeLimitation(JSONObject rule) {
        try {
            String dynamicListId = rule.getString("dynamicListId");
            String campaignID = rule.getString("campaignId");
            String blastedCampaignKey = dynamicListId + campaignID;
            String alreadyBlasted = SharedPref.getInstance().getStringValue(context, blastedCampaignKey);
            JSONArray jsonArray = rule.getJSONArray("rules");


            if (jsonArray.length() == 1) {
                String ruleName = jsonArray.getJSONObject(0).getString("ruleName").toLowerCase();
                switch (ruleName) {

                    case "app install":
                    case "app installed date":
                    case "app updated date":
                    case "app version code":
                    case "app version name":
                    case "device type":
                    case "language":
                    case "new visitors":
                    case "notification disabled":
                    case "operating systems":
                    case "returning visitors":
                    case "user type":
                    case "version":
                        if (alreadyBlasted.equalsIgnoreCase(blastedCampaignKey))
                            return false;
                        break;
                    case "app updated":
                        if (alreadyBlasted.equalsIgnoreCase(blastedCampaignKey) && !appUpdateValidation())
                            return false;
                        break;

                    case "location":
                        if (alreadyBlasted.equalsIgnoreCase(blastedCampaignKey) && LastBlastedLocation(rule))
                            return false;
                        break;
                    case APP_SESSION_DURATION:
                        if (alreadyBlasted.equalsIgnoreCase(blastedCampaignKey) && sessionDurationRules.contains(dynamicListId))
                            return false;
                        break;


                }
                return true;
            } else {
                String rulesList = jsonArray.toString().toLowerCase();
                if (!rulesList.contains(APP_SESSION_DURATION)
                        && !rulesList.contains(APP_USER_VIEW_SPECIFIC_SCREEN)
                        && !rulesList.contains(APP_TIME_SPEND_ON_SCREEN)
                        && !rulesList.contains(APP_LAST_VISITED_SCREEN)
                        && !rulesList.contains(APP_SCREEN_VIEWS)
                        && !rulesList.contains(APP_LOCATION)
                        && !rulesList.contains(APP_CUSTOM_EVENTS)
                        && !rulesList.contains(LOGIN)
                        && !rulesList.contains(APP_OPENED)
                        && !rulesList.contains(APP_IN_BACKGROUND)
                        && !rulesList.contains(APP_CLOSED + "\"")) {
                    if (alreadyBlasted.equalsIgnoreCase(blastedCampaignKey)) {
                        return false;
                    }

                } else {
                    if (rulesList.contains(LOGIN) ||
                            rulesList.contains(APP_CLOSED) ||
                            rulesList.contains(APP_OPENED) ||
                            rulesList.contains(APP_IN_BACKGROUND) ||
                            rulesList.contains(APP_CUSTOM_EVENTS) ||
                            rulesList.contains(APP_SESSION_DURATION) ||
                            rulesList.contains(APP_USER_VIEW_SPECIFIC_SCREEN) ||
                            rulesList.contains(APP_LAST_VISITED_SCREEN) ||
                            rulesList.contains(APP_TIME_SPEND_ON_SCREEN) ||
                            rulesList.contains(APP_SCREEN_VIEWS)) {

                        if ((rulesList.contains(APP_TIME_SPEND_ON_SCREEN) || rulesList.contains(APP_SESSION_DURATION)) && campaignBlastedId.contains(blastedCampaignKey))
                            return false;
                        else
                            return true;

                    }

                    if (rulesList.contains(APP_UPDATED)) {
                        if (appUpdateValidation())
                            return true;
                    }

                    if (rulesList.contains(APP_LOCATION)) {
                        return !LastBlastedLocation(rule);
                    }

                    return false;
                }
            }
        } catch (Exception e) {
        }
        return true;
    }

    private void triggerBlast(JSONObject rule) {
        try {
            if (rule.toString().toLowerCase().contains("location"))
                storeLocation();

            if (rule.toString().toLowerCase().contains("app update"))
                appUpdate();

            String dynamicListId = rule.getString("dynamicListId");
            String campaignID = rule.getString("campaignId");
            String blastedCampaignKey = dynamicListId + campaignID;
            // Log.e("Rules ****** statisfied ****", rule.getString("dynamicListName"));
            // SharedPref.getInstance().setSharedValue(context, blastedCampaignKey, blastedCampaignKey);
            callAPI(rule, blastedCampaignKey);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    private void callAPI(JSONObject jsonObject, String blastId) {
        try {
            JSONObject object = new JSONObject();
            object.put("campaignId", jsonObject.getString("campaignId"));
            object.put("dynamicListId", jsonObject.getString("dynamicListId"));
            object.put("tenantId", tenantID);
            try {
                if (CustomEventsData.containsKey(jsonObject.getString("campaignId"))) {
                    object.put("data", CustomEventsData.get(jsonObject.getString("campaignId")));
                }
            } catch (Exception e) {

            }

            DataNetworkHandler.getInstance().apiCallCampaignBlastAPI(context, object, blastId);
        } catch (Exception e) {
            ExceptionTracker.track(e);
        }
    }

    private boolean ruleEngineAll(JSONArray rules, String campaignId) {
        try {

            for (int j = 0; j < rules.length(); j++) {
                JSONObject rule = rules.getJSONObject(j);
                if (!ruleIsValid(rule, campaignId)) {
                    Log.e(rule.getString("ruleName") + " rule", " Not matched");
                    return false;
                } else {
                    Log.e(rule.getString("ruleName") + " rule", " matched");
                }
            }
            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    private int ruleEngineAny(JSONArray rules, String campaignId) {
        try {
            ArrayList<JSONObject> jsonObjects = new ArrayList<>();
            for (int j = 0; j < rules.length(); j++) {
                JSONObject rule = rules.getJSONObject(j);
                if (rule.getBoolean("isMandatory")) {
                    if (ruleIsValid(rule, campaignId))
                        jsonObjects.add(rule);
                    else {
                        return 0;
                    }
                } else {
                    if (ruleIsValid(rule, campaignId)) {
                        jsonObjects.add(rule);
                    }
                }
            }
            return jsonObjects.size();

        } catch (Exception e) {

        }
        return 0;
    }

    private boolean ruleIsValid(JSONObject rule, String campaignId) {

        try {
            String ruleName = rule.getString("ruleName").toLowerCase();
            switch (ruleName) {

                case NEW_VISITOR:
                    if (!ruleNewVisitor()) {
                        Log.e("Rules NEW_VISITOR", "Not matched");
                        return false;
                    }
                    break;

                case RETURN_VISITOR:
                    if (!ruleReturnVisitor()) {
                        Log.e("Rules RETURN_VISITOR", "Not matched");
                        return false;
                    }
                    break;

                case APP_INSTALLED_DATE:
                    if (!ruleAppInstalledDate(rule.getInt("value"))) {
                        Log.e("Rules APP_INSTALLED_DATE", "Not matched");
                        return false;
                    }
                    break;
                case APP_INSTALL:
                    if (!ruleAppInstalled()) {
                        Log.e("Rules APP_INSTALL", "Not matched");
                        return false;
                    }
                    break;
                case APP_UPDATED_DATE:
                    if (!ruleAppUpdatedDate(rule.getInt("value"))) {
                        Log.e("Rules APP_UPDATED_DATE", "Not matched");
                        return false;
                    }
                    break;
                case APP_UPDATED:
                    if (!ruleAppUpdated()) {
                        Log.e("Rules APP_UPDATED", "Not matched");
                        return false;
                    }
                    break;
                case APP_OPENED_DATE:
                    if (!ruleAppClosedDate(rule.getInt("value"))) {
                        Log.e("Rules APP_OPENED_DATE", "Not matched");
                        return false;
                    }
                    break;
                case APP_OPENED:
                    if (Util.isAppIsInBackground(context)) {
                        Log.e("Rules APP_OPENED", "Not matched");
                        return false;
                    }
                    break;

                case APP_VERSION_CODE:
                    if (!ruleAppVersionCode(rule.getString("value"))) {
                        Log.e("Rules APP_VERSION_CODE", "Not matched");
                        return false;
                    }
                    break;

                case APP_VERSION_NAME:
                    if (!ruleAppVersionName(rule.getString("value"))) {
                        Log.e("Rules APP_VERSION_NAME", "Not matched");
                        return false;
                    }
                    break;

                case APP_DEVICE_TYPE:
                    if (!rule.getString("value").toLowerCase().contains(ruleDeviceType(context))) {
                        Log.e("Rules APP_DEVICE_TYPE", "Not matched");
                        return false;
                    }
                    break;
                case APP_LANGUAGE:
                    if (!ruleAppLanguage(rule.getString("value"))) {
                        Log.e("Rules APP_LANGUAGE", "Not matched");
                        return false;
                    }
                    break;
                case APP_NOTIFICATION_DISABLED:
                    if (!ruleNotificationDisabled(rule.getString("value"))) {
                        Log.e("Rules APP_NOTIFICATION_DISABLED", "Not matched");
                        return false;
                    }
                    break;
                case APP_OS:

                    if (rule.getString("value").toLowerCase().contains("android")) {
                        rule.put("value", "Android");
                    }

                    if (!rule.getString("value").toLowerCase().contains(DEVICE_OS.toLowerCase())) {
                        Log.e("Rules DEVICE_OS", "Not matched");
                        return false;
                    }
                    break;
                case APP_USER_TYPE:
                    if (!rule.getString("value").toLowerCase().contains(ruleUserType(context).toLowerCase())) {
                        Log.e("Rules APP_USER_TYPE", "Not matched");
                        return false;
                    }
                    break;

                case LOGIN:
                    if (!appUserLogin) {
                        Log.e("Rules APP_LOGIN", "Not matched");
                        return false;
                    }
                    break;
                case APP_LAST_VISITED_SCREEN:
                    if (!ruleLastVisited(context, rule.getString("value"))) {
                        Log.e("Rules APP_LAST_VISITED_SCREEN", "Not matched");
                        return false;
                    }
                    break;
                case APP_CLOSED_DATE:
                    if (!ruleAppClosedDate(rule.getInt("value"))) {
                        Log.e("Rules APP_CLOSED_DATE", "Not matched");
                        return false;
                    }
                    break;
                case APP_USER_VIEW_SPECIFIC_SCREEN:
                    boolean result = ruleUserVisiting(rule.getString("value"));
                    if (!result) {
                        Log.e("Rules APP_USER_VIEW_SPECIFIC_SCREEN", "Not matched");
                        return false;
                    }
                    break;
                case APP_CUSTOM_EVENTS:
                    if (!(rule.getString("value").toLowerCase()).contains(getCurrentEventName().toLowerCase())) {
                        Log.e("Rules APP_CUSTOM_EVENTS", "Not matched");
                        return false;
                    } else {
                        CustomEventsData.put(campaignId, CustomEvents.get(getCurrentEventName()));
                    }
                    break;
                case APP_SESSION_DURATION:
                    if (!sessionDuration(rule.getString("value"))) {
                        Log.e("Rules APP_SESSION_DURATION", "Not matched");
                        return false;
                    }
                    break;
                case APP_TIME_SPEND_ON_SCREEN:
                    if (!onPageSessionDuration(rule.getString("value"))) {
                        Log.e("Rules APP_TIME_SPEND_ON_SCREEN", "Not matched");
                        return false;
                    }
                    break;
                case APP_LOCATION:
                    if (!rule.getString("value").toLowerCase().contains(getCurrentCityName().toLowerCase()) && !rule.getString("value").toLowerCase().contains(getCurrentStateName().toLowerCase()) && !rule.getString("value").toLowerCase().contains(getCurrentCountryName().toLowerCase())) {
                        Log.e("Rules APP_LOCATION", "Not matched");
                        storeLocation();
                        return false;
                    }
                    break;
                case APP_SCREEN_VIEWS:
                    if (!screenViews(rule.getString("value"))) {
                        Log.e("Rules APP_SCREEN_VIEWS", "Not matched");
                        return false;
                    }
                    break;

                case APP_IN_BACKGROUND:
                    if (!ruleAppInBackground(rule.getString("value"))) {
                        Log.e("Rules APP_IN_BACKGROUND", "Not matched");
                        return false;
                    }
                    break;
                case APP_CLOSED:
                    if (!appClose) {
                        Log.e("Rules APP_CLOSED", "Not matched");
                        return false;
                    }
                    break;


                case APP_CLOSE:
                    if (!appClose) {
                        Log.e("Rules APP_CLOSED", "Not matched");
                        return false;
                    }
                    break;

                case DEVICE_OS_VERSION:

                    if (!rule.getString("value").contains(Build.VERSION.RELEASE)) {
                        Log.e("Rules DEVICE_OS_VERSION", "Not matched");
                        return false;
                    }
                    break;

                default:
                    Log.e(ruleName + ": *******  This Rule Not ", "matched with defined rules *******");
                    Integer.parseInt(ruleName);
                    break;
            }

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    private String getCurrentActivityName() {
        return CURRENT_ACTIVITY_NAME;
        //  return SharedPref.getInstance().getStringValue(context, "CurrentActivityName");
    }

    private String getCurrentFragmentName() {
        return CURRENT_FRAGMENT_NAME;
        //return SharedPref.getInstance().getStringValue(context, "CurrentFragmentName");
    }

    private String getCurrentEventName() {
        return APP_CURRENT_EVENT;
    }

    private String getCurrentCityName() {
        return SharedPref.getInstance().getStringValue(context, "CurrentCityName");
    }

    private String getCurrentStateName() {
        return SharedPref.getInstance().getStringValue(context, "CurrentStateName");
    }

    private String getCurrentCountryName() {
        return SharedPref.getInstance().getStringValue(context, "CurrentCountryName");
    }

    private boolean sessionDuration(String value) {
        try {


            String timeSpent = Util.appSession(Util.getStringToUTC(appOpenTime), Util.getStringToUTC(Util.getCurrentUTC()));
            Long sec = Long.parseLong(timeSpent);
            if (Util.isAppIsInBackground(context)) {
                Log.e("APP_SESSION_DURATION _ AppIsInBackground", "Not matched");
                return false;
            }

            switch (value) {

                case "Less than 10 secs":
                case "Less than 10sec":
                    if (sec > 3)
                        return true;
                    break;
                case "11 secs to 30 secs":
                case "11sec to 30sec":
                    if (sec > 11)
                        return true;
                    break;
                case "31 secs to 60 secs":
                case "31sec to 60sec":
                    if (sec > 31)
                        return true;
                    break;

                case "More than 60 secs":
                case "More than 60sec":
                    if (sec > 60)
                        return true;
                    break;

            }
        } catch (Exception e) {

        }
        return false;
    }

    private boolean onPageSessionDuration(String value) {
        try {


            String timeSpent = Util.appSession(Util.getStringToUTC(pageStartTime), Util.getStringToUTC(Util.getCurrentUTC()));
            Long sec = Long.parseLong(timeSpent);
            if (Util.isAppIsInBackground(context)) {
                Log.e("APP_TIME_SPEND_ON_SCREEN _ AppIsInBackground", "Not matched");
                return false;
            }

            switch (value) {

                case "Less than 10 secs":
                case "Less than 10sec":
                    if (sec > 3)
                        return true;
                    break;
                case "11 secs to 30 secs":
                case "11sec to 30sec":
                    if (sec > 11)
                        return true;
                    break;
                case "31 secs to 60 secs":
                case "31sec to 60sec":
                    if (sec > 31)
                        return true;
                    break;

                case "More than 60 secs":
                case "More than 60sec":
                    if (sec > 60)
                        return true;
                    break;
            }
        } catch (Exception e) {

        }
        return false;
    }

    private boolean screenViews(String value) {

        try {
            switch (value) {
                case "Less than 2":
                    if (screenViews > 1)
                        return true;
                    break;
                case "2 to 4":
                    if (screenViews > 3)
                        return true;
                    break;
                case "5 to 7":
                    if (screenViews > 6)
                        return true;
                    break;
                case "More than 7":
                    if (screenViews > 7)
                        return true;
                    break;
            }
        } catch (Exception e) {

        }
        return false;
    }


    private String ruleDeviceType(Context context) {

        try {
            boolean xlarge = ((context.getResources().getConfiguration().screenLayout & Configuration.SCREENLAYOUT_SIZE_MASK) == 4);
            boolean large = ((context.getResources().getConfiguration().screenLayout & Configuration.SCREENLAYOUT_SIZE_MASK) == Configuration.SCREENLAYOUT_SIZE_LARGE);
            if ((xlarge || large))
                return "Android Tab".toLowerCase();
            else
                return "Android Phone".toLowerCase();

        } catch (Exception e) {
            return "";
        }

    }


    private boolean ruleNewVisitor() {
        try {
            int visitorCount = SharedPref.getInstance().getIntValue(context, "visitorCount");
            return visitorCount == 1;
        } catch (Exception e) {

        }
        return false;

    }

    private boolean ruleReturnVisitor() {
        try {
            int visitorCount = SharedPref.getInstance().getIntValue(context, "visitorCount");
            return visitorCount > 1;
        } catch (Exception e) {

        }
        return false;
    }


    // initialize rule
    private boolean ruleAppInstalled() {
        try {
            Date appinstalled = Util.getStringToUTC(Util.getAppFirstInstallTime(context));
            Date currentDate = Util.getStringToUTC(Util.getCurrentUTC());
            long difference = currentDate.getTime() - appinstalled.getTime();
            long differenceDays = difference / (24 * 60 * 60 * 1000);
            return differenceDays == 0;
        } catch (Exception e) {

        }
        return false;
    }


    // initialize rule
    private boolean ruleAppUpdated() {
        try {
            Date appUpdated = Util.getStringToUTC(Util.getAppUpdateTime(context));
            Date currentDate = Util.getStringToUTC(Util.getCurrentUTC());
            long difference = currentDate.getTime() - appUpdated.getTime();
            long differenceDays = difference / (24 * 60 * 60 * 1000);
            return differenceDays == 0;
        } catch (Exception e) {

        }
        return false;
    }

    private boolean ruleAppInstalledDate(int numberOfDays) {
        try {
            Date appinstalled = Util.getStringToUTC(Util.getAppFirstInstallTime(context));
            Calendar calendar = Calendar.getInstance();
            long difference = calendar.getTime().getTime() - appinstalled.getTime();
            long differenceDays = difference / (24 * 60 * 60 * 1000);
            return differenceDays >= numberOfDays;
        } catch (Exception e) {

        }
        return false;
    }

    private boolean ruleAppUpdatedDate(int numberOfDays) {
        try {
            Date appUpdated = Util.getStringToUTC(Util.getAppUpdateTime(context));
            Calendar calendar = Calendar.getInstance();
            long difference = calendar.getTime().getTime() - appUpdated.getTime();
            long differenceDays = difference / (24 * 60 * 60 * 1000);
            return differenceDays >= numberOfDays;
        } catch (Exception e) {

        }
        return false;
    }

    private boolean ruleAppClosedDate(int numberOfDays) {
        try {
            Date appUpdated = Util.getStringToUTC(SharedPref.getInstance().getStringValue(context, LAST_APP_OPENED));
            Calendar calendar = Calendar.getInstance();
            long difference = calendar.getTime().getTime() - appUpdated.getTime();
            long differenceDays = difference / (24 * 60 * 60 * 1000);
            return differenceDays <= numberOfDays;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }


    // initialize rule
    String ruleUserType(Context context) {

        try {
            String UserId = SharedPref.getInstance().getStringValue(context, AppConstants.reSharedUserId);
            if (!TextUtils.isEmpty(UserId))
                return "identified";
            else
                return "known";


        } catch (Exception e) {

        }
        return "";
    }


    // initialize rule
    boolean ruleLastVisited(Context context, String value) {

        try {
            //String activityName = SharedPref.getInstance().getStringValue(context, LAST_VISITED_ACTIVITY);
            //  String fragmentFragment = SharedPref.getInstance().getStringValue(context, LAST_VISITED_FRAGMENT);
            String activityName = AppConstants.LAST_ACTIVITY_NAME;
            String fragmentFragment = AppConstants.LAST_FRAGMENT_NAME;

            Log.e("Rules Last activityName", activityName);
            Log.e("Rules Last fragment", fragmentFragment);
            Log.e("Rules value", value);
            if (!TextUtils.isEmpty(activityName)) {
                if (value.toLowerCase().contains(activityName.toLowerCase())) {
                    return true;
                }
            }
            if (!TextUtils.isEmpty(fragmentFragment)) {
                if (value.toLowerCase().contains(fragmentFragment.toLowerCase())) {
                    return true;
                }
            }

        } catch (Exception e) {

        }
        return false;
    }

    // initialize rule
    public boolean ruleUserVisiting(String value) {

        try {
            String activityName = getCurrentActivityName().toLowerCase();
            String fragment = getCurrentFragmentName().toLowerCase();
            value = value.toLowerCase();
            Log.e("Rules activityName", activityName);
            Log.e("Rules fragment", fragment);
            Log.e("Rules value", value);
            if (!TextUtils.isEmpty(activityName) && !TextUtils.isEmpty(value)) {
                if (value.toLowerCase().contains(activityName.toLowerCase())) {
                    return true;
                }
            }
            if (!TextUtils.isEmpty(fragment) && !TextUtils.isEmpty(value)) {
                return value.toLowerCase().contains(fragment.toLowerCase());
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // initialize rule
    private boolean ruleAppInBackground(String value) {

        try {
            boolean flag;
            flag = value.toLowerCase().contains("yes");
            if (flag) {
                return (Util.isAppIsInBackground(context) || appClose);
            } else {
                return (!Util.isAppIsInBackground(context));
            }
        } catch (Exception e) {
            return false;
        }

    }

    // initialize rule
    private boolean ruleNotificationDisabled(String value) {
        try {
            boolean flag;
            flag = value.toLowerCase().contains("yes");
            if (flag) {
                return (!NotificationManagerCompat.from(context).areNotificationsEnabled());
            } else {
                return (NotificationManagerCompat.from(context).areNotificationsEnabled());
            }
        } catch (Exception e) {
            return false;
        }
    }

    // initialize rule
    private boolean ruleAppVersionCode(String versionCode) {
        try {
            return versionCode.toLowerCase().contains(Util.getAppVersionCode(context).toLowerCase());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // initialize rule
    private boolean ruleAppVersionName(String versionName) {
        try {
            return versionName.toLowerCase().contains(Util.getAppVersionName(context).toLowerCase());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // initialize rule
    private boolean ruleAppLanguage(String appLanguage) {
        try {
            return appLanguage.toLowerCase().contains(Locale.getDefault().getDisplayLanguage().toLowerCase());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }


    public String getLocationFromAddress(Context context, double latitude, double longitude) {

        try {
            Geocoder geocoder;
            List<Address> addresses;
            geocoder = new Geocoder(context, Locale.getDefault());

            String finaladdress = "";
            addresses = geocoder.getFromLocation(latitude, longitude, 1);
            String address = addresses.get(0).getAddressLine(0); // If any additional address line present than only, check with max available address lines by getMaxAddressLineIndex()
            String city = addresses.get(0).getLocality();
            String state = addresses.get(0).getAdminArea();
            String country = addresses.get(0).getCountryName();
            String postalCode = addresses.get(0).getPostalCode();
            String knownName = addresses.get(0).getFeatureName();
            SharedPref.getInstance().setSharedValue(context, "CurrentCityName", city);
            SharedPref.getInstance().setSharedValue(context, "CurrentStateName", state);
            SharedPref.getInstance().setSharedValue(context, "CurrentCountryName", country);

            Log.e("Address", " City :" + city + "State :" + state + " Country :" + country + "Address :" + address);

            return " City :" + city + "State :" + state + " Country :" + country + "Address :" + address;
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Here 1 represent max location result to returned, by documents it recommended 1 to
        return "";
    }

    private class RulesEngine /*extends AsyncTask<String, JSONObject, JSONObject>*/ {

        ArrayList<JSONObject> rules;
        boolean appBackground = true;

        RulesEngine(ArrayList<JSONObject> rules, boolean appBackground) {
            this.rules = rules;
            this.appBackground = appBackground;
        }

        RulesEngine(ArrayList<JSONObject> rules) {
            this.rules = rules;
        }


        void executeOnExecutor(Executor executors) {
            try {
                ExecutorService executor = Executors.newSingleThreadExecutor();
                Handler handler = new Handler(Looper.getMainLooper());
                executor.execute(() -> {
                    try {
                        ArrayList<JSONObject> list = new ArrayList<>();
                       /* if (!Util.isAppIsInBackground(context)) {
                            list = doInBackground();
                        } else if (!appBackground) {*/
                        list = doInBackground();
                        ///}

                        //Background work here
                        //UI Thread work here
                        ArrayList<JSONObject> finalList = list;
                        handler.post(() -> {
                            //UI Thread work here
                            try {
                                for (JSONObject jsonObject : finalList) {
                                    triggerBlast(jsonObject);
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

        private ArrayList<JSONObject> doInBackground(String... urls) {
            return processRules(rules);
        }


    }

    private class RuleFinding /*extends AsyncTask<String, String, String>*/ {


        void execute() {
            try {
                ExecutorService executor = Executors.newSingleThreadExecutor();
                Handler handler = new Handler(Looper.getMainLooper());
                executor.execute(() -> {
                    try {
                        doInBackground();
                    } catch (Exception e) {

                    }
                    //Background work here
                    //UI Thread work here
                    handler.post(() -> {
                        //UI Thread work here
                        try {
                            AppRuleListener.getInstance().processEntryRules(context);
                        } catch (Exception e) {

                        }
                    });
                });
            } catch (Exception e) {

            }
        }

        private String doInBackground(String... urls) {
            getRules();
            return "";
        }

    }


}
