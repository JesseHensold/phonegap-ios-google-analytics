if (!window.GA) {
    window.GA = {
    	/**
		* Initialize Google Analytics configuration
		* @param accountId  your google analytics account id
		* @param successCallback The success callback
		* @param failureCallback The error callback
		*/
        startTracker:function(accountId,success,fail){
            var options = {
                accountId:accountId
            };
            return cordova.exec(success,fail,
                "GoogleAnalyticsPlugin",
                "startTracker",
                [options]
            );
        },
        /**
		* Set a custom dimension
		* Note: This is new to Google Analytics v2.0;
		* 		You must set this dimension in the Admin panel on Google Analytics
		* @param index The index of the dimension (set on Google Analytics)
		* @param value The value to set
		* 
		* @param successCallback The success callback
		* @param failureCallback The error callback
		 */
        setCustomDimension:function(index, value,success,fail){
            var options = {
                index:index,
                value:value
            };
            return cordova.exec(success,fail,
                "GoogleAnalyticsPlugin",
                "setCustomDimension",
                [options]
            );
        },
        /**
		* Track a page view on Google Analytics
		* @param screen The name of the tracked item (can be a url or some logical name).
		* The key name will be presented in Google Analytics report.
		* @param successCallback The success callback
		* @param failureCallback The error callback
		*/
        trackView: function(screen,success,fail) {
            var options={
                screen:screen
            };
            return cordova.exec(success,fail,
                "GoogleAnalyticsPlugin",
                "trackView",
                [options]
            );
            console.log("trackView Initialized");
        },
        
        /**
		* Track an event on Google Analytics
		* @param category The name that you supply as a way to group objects that you want to track
		* @param action The name the type of event or interaction you want to track for a particular web object
		* @param label Provides additional information for events that you want to track (optional)
		* @param value Assign a numerical value to a tracked page object (optional)
		
		* @param successCallback The success callback
		* @param failureCallback The error callback
		*/
        trackEvent: function(category,action,label,value,success,fail) {
            var options = {
                category:category,
                action:action,
                label:label,
                value:value};
            return cordova.exec(success,fail,
                "GoogleAnalyticsPlugin",
                "trackEvent",
                [options]
            );
        },
        
        /**
		* Track a timing event on Google Analytics (Beta)
		* Note: This is still in Beta on Google Analytics
		* @param category The category of timing
		* @param time The timing value to track
		* @param name The name of the timing value
		* @param label Provides additional information for timing events that you want to track (optional)
		
		* @param successCallback The success callback
		* @param failureCallback The error callback
		*/
        trackTiming:function(category,time,name,label,success,fail){
            var options = {
                category:category,
                time:time,
                name:name,
                label:label};
            return cordova.exec(success,fail,
                "GoogleAnalyticsPlugin",
                "trackTiming",
                [options]
            );
        },
        hitDispatched: function(hitString) {
            console.log("hitDispatched :: " + hitString);
        },
        trackerDispatchDidComplete: function(count) {
            console.log("trackerDispatchDidComplete :: " + count);
        }
    }
}
