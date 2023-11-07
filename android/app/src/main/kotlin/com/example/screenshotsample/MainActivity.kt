package com.example.screenshotsample

import android.app.Activity
import android.content.Context
import android.graphics.Bitmap
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.util.Base64
import android.util.Log
import android.widget.EditText
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.embedding.engine.renderer.FlutterRenderer
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import io.flutter.view.FlutterView
import io.mob.resu.reandroidsdk.AppConstants
import io.mob.resu.reandroidsdk.MRegisterUser
import io.mob.resu.reandroidsdk.ReAndroidSDK
import org.json.JSONArray
import org.json.JSONException
import org.json.JSONObject
import java.io.File
import java.io.FileOutputStream
import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Date



class MainActivity: FlutterFragmentActivity() {
    private var context: Context? = null
    private val CHANNEL = "samples.flutter.dev"
    private lateinit var channel: MethodChannel
    private var oldCalendar = Calendar.getInstance()
    private var sCalendar = Calendar.getInstance()

    var deepData: String? = null
    var OldScreenName: String? = null
    var newScreenName: String? = null
    var activity: Activity? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        AppConstants.isCordova = true;
        AppConstants.isHyBird = true;
        AppConstants.LogFlag = true;
        ReAndroidSDK.getInstance(this)
        context=applicationContext
    }



    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {

        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "locationUpdate" -> {
                    var lat: Double? = call?.argument("lat")
                    var lang: Double? = call?.argument("lang")
                    if (lat != null && lang != null) {
                        ReAndroidSDK.getInstance(context).onLocationUpdate(lat,lang)
                    }
                }
                "sdkRegisteration" -> {
                    val userDataJObj = JSONObject(call.arguments as Map<String, String>)
                    val mRegisterUser = MRegisterUser()
                    mRegisterUser.userUniqueId = userDataJObj.optString("userUniqueId")
                    mRegisterUser.name = userDataJObj.optString("name")
                    mRegisterUser.age = userDataJObj.optString("age")
                    mRegisterUser.email = userDataJObj.optString("email")
                    mRegisterUser.phone = userDataJObj.optString("phone")
                    mRegisterUser.gender = userDataJObj.optString("gender")
                    mRegisterUser.deviceToken = userDataJObj.optString("deviceToken")
                    mRegisterUser.profileUrl = userDataJObj.optString("profileUrl")
                    mRegisterUser.dob = userDataJObj.optString("dob")
                    mRegisterUser.education = userDataJObj.optString("education")
                    mRegisterUser.isEmployed = userDataJObj.optBoolean("employed")
                    mRegisterUser.isMarried = userDataJObj.optBoolean("married")
                    mRegisterUser.adId = userDataJObj.optString("adId")
                    ReAndroidSDK.getInstance(context).onDeviceUserRegister(mRegisterUser)
                }
                "customEvent" -> {
                    //ReAndroidSDK.getInstance(context).onTrackEvent(call.arguments())
                }
                "getFieldTrackList" -> {
                    val jsonObjectList: ArrayList<JSONObject> = ReAndroidSDK.getInstance(context).fieldTrackList

                    // Convert ArrayList<JSONObject> to List<Map<String, Any>>
                    val jsonArray = ArrayList<Map<String, Any>>()
                    for (jsonObject in jsonObjectList) {
                        try {
                            val jsonMap = mutableMapOf<String, Any>()
                            val names = jsonObject.names()
                            if (names != null) {
                                for (i in 0 until names.length()) {
                                    val key = names.getString(i)
                                    val value = jsonObject.get(key)
                                    jsonMap[key] = value
                                }
                            }
                            jsonArray.add(jsonMap)
                        } catch (e: JSONException) {
                            e.printStackTrace()
                        }
                    }
                    result.success(jsonArray)

                }
                "screenLables" -> {
                    val myList = call.arguments as List<String?>
                    try {
                        val jsonArray = JSONArray(myList)
                        val jsonObject = JSONObject()
                        jsonObject.put("list", jsonArray)
                    } catch (e: JSONException) {
                        e.printStackTrace()
                        // Handle the JSON exception
                    }
                }
                "screenTracking" -> {

                    if(context ==null) {
                        activity = Activity();
                        this.context = activity;
                    }
                    val screenName: String? = call.arguments()
                    if(context==null){
                    }
                }
//                "takeScreenshot" -> {
//                    takeScreenshotNew()
//                    result.success(ssPath)
//                }
                "passScreenshotData" -> {
                    var data:String = call.arguments.toString()
//                    AppConstants.isHyBird = true
                    val imgFile = File(data)
                    val imageBytes = imgFile.readBytes()
                    val base64String = Base64.encodeToString(imageBytes, Base64.DEFAULT)
                    ReAndroidSDK.getInstance(this).getImage(base64String)
                   // Log.e("ScreenshotData", "$data")
                }
                "updateViewsJson" -> {
                    AppConstants.hybridViewsJson = JSONArray(call.arguments as List<Map<String,Any>>);
                  //  print("UpdateViewJson :: ${call.arguments}")
                    //AppConstants.HybridScreenUrl = cordova.getActivity().getClass().getSimpleName();
                }
                "startTextChangeListener" ->{
                    // Implement your text change listener here
                    // Example: Listen for text changes in an EditText
                    val editText = EditText(this)
                    editText.addTextChangedListener(object : TextWatcher {
                        override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {
                            // Not needed for this example
                        }

                        override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
                            // Send the updated text to Flutter
                            val newText = s?.toString() ?: ""
                            result.success(newText)
                        }

                        override fun afterTextChanged(s: Editable?) {
                            // Not needed for this example
                        }
                    })




                }

                else -> {
                    if (result != null) {
                        result.notImplemented()
                    }
                }
            }
        }
    }

}

