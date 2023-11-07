package io.mob.resu.reandroidsdk;

import static io.mob.resu.reandroidsdk.error.Util.isButton;

import android.app.Activity;
import android.os.Handler;
import android.os.Looper;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.RadioButton;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.ToggleButton;

import com.bumptech.glide.Glide;

import org.json.JSONObject;

import java.util.ArrayList;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import io.mob.resu.reandroidsdk.error.ExceptionTracker;
import io.mob.resu.reandroidsdk.error.Util;


public class EnableFieldCapture /*extends AsyncTask<String, String, JSONObject> */ {

    private final String screenName;
    Activity activity;
    private ArrayList<JSONObject> captureIds = new ArrayList<>();

    EnableFieldCapture(Activity activity, String screenName) {
        this.activity = activity;
        this.screenName = screenName;
    }


    void execute() {
        try {
            ExecutorService executor = Executors.newSingleThreadExecutor();
            Handler handler = new Handler(Looper.getMainLooper());
            executor.execute(() -> {
                try {
                    JSONObject jsonObject = doInBackground();
                    //Background work here
                    //UI Thread work here
                    handler.post(() -> {
                        //UI Thread work here
                        try {
                            onPostExecute(jsonObject);
                        } catch (Exception e1) {
                        }
                    });
                } catch (Exception e) {

                }
            });
        } catch (Exception e) {

        }
    }


    private void onPostExecute(JSONObject jsonObject1) {
        try {
            if (captureIds != null) {
                if (captureIds.size() > 0) {
                    View view = activity.getWindow().getDecorView().getRootView();
                    for (JSONObject id : captureIds) {
                        try {
                            View view1 = null;
                            int resID = activity.getResources().getIdentifier(id.getString("identifier"), "id", activity.getPackageName());
                            view1 = view.findViewById(resID);

                            if (view1 != null) {
                                view1.setAccessibilityDelegate(new EventTrackingListener());
                                view1.setOnTouchListener(new EventSenseListener());
                                if (!isButton(view1)) {
                                    AppLifecyclePresenter.getInstance().fieldWiseDataListener(view1);
                                }
                                if (id.has("formId") && id.has("result")) {
                                    if (!TextUtils.isEmpty(id.getString("result"))) {
                                        setValues(id, view1);
                                    }
                                }
                            }
                        } catch (Exception e) {
                            ExceptionTracker.track(e);
                        }
                    }
                }
            } else {
                Log.e("", "Screen name :" + screenName + " No field track data ");

            }
        } catch (Exception e) {
            ExceptionTracker.track(e);
        }

    }

    private JSONObject doInBackground(String... params) {
        try {
            captureIds = new DataBase(activity).getFieldTracking(DataBase.Table.REGISTER_EVENT_TABLE, screenName);
            if (captureIds != null) {
                Log.e("1000", "Field Track data ScreenName :" + screenName + " Count :" + captureIds.size());
            }
            // Log.e("1000", "Field Track data ScreenName :" + screenName + " Count :"+ captureIds.size());
            //Log.e("1000", "Field Track data ScreenName :" + screenName + " Count :"+ captureIds.size());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private void setValues(JSONObject values, View view) {

        try {
            String result = values.getString("result");
            if (Util.isTextView(view)) {
                TextView v1 = (TextView) view;
                v1.setText(result);
            } else if (Util.isButton(view)) {
                Button v1 = (Button) view;
                v1.setText(result);
            } else if (Util.isEditText(view)) {
                EditText v1 = (EditText) view;
                v1.setText(result);
            } else if (Util.isToggleButton(view)) {
                ToggleButton v1 = (ToggleButton) view;
                v1.setText(result);
            } else if (Util.isCheckBox(view)) {
                CheckBox v1 = (CheckBox) view;
                v1.setText(result);
            } else if (Util.isRadioButton(view)) {
                RadioButton v1 = (RadioButton) view;
                v1.setText(result);
            } else if (Util.isImageView(view)) {
                ImageView imageView = (ImageView) view;
                Glide.with(activity)
                        .load(result)
                        .into(imageView);
            } else if (Util.isSpinner(view)) {
                Spinner v1 = (Spinner) view;
                ArrayAdapter myAdap = (ArrayAdapter) v1.getAdapter(); //cast to an ArrayAdapter
                int spinnerPosition = myAdap.getPosition(result);
                v1.setSelection(spinnerPosition);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }


    }


}