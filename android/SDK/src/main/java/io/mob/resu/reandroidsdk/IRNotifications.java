package io.mob.resu.reandroidsdk;

import org.json.JSONObject;

import java.util.ArrayList;

public interface IRNotifications {

    default void getReadCount(int count) {
    }

    default void getUnreadCount(int count) {
    }

    default void getNotificationByObject(ArrayList<JSONObject> jsonObjects) {
    }

    default void getNotifications(ArrayList<RNotification> rNotifications) {
    }

}
