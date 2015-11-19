cordova.define("com.example.meiriqCordovaC2.meiriqCordovaC2", function(require, exports, module) { /*global cordova, module*/

module.exports = {
    greet: function (name, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "MeiriqCordovaC2", "greet", [name]);
    }
};

});
