package com.example.plugin;

import org.apache.cordova.*;
import org.json.JSONArray;
import org.json.JSONException;

public class MeiriqCordovaC2 extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray data, CallbackContext callbackContext) throws JSONException {

        if (action.equals("greet")) {

            String name = data.getString(0);
            String message = "MeiriqCordovaC2, " + name;
            callbackContext.success(message);

            return true;

        } else {

            return false;

        }
    }
}
