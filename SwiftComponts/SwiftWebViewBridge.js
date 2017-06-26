window.log = (function(){
    var uniqueId = 1;
    function _log(message, data) {
        var logElem = document.getElementById("logContainer");
        var newElem = document.createElement("div");
        newElem.className = "logLine";
        if (data) {
            console.log(message + ":<br/>" + data);
            newElem.innerHTML = uniqueId++ + '. ' + message + ':<br/>' + JSON.stringify(data);
        }
        else {
            console.log(message); 
            newElem.innerHTML = uniqueId++ + '. ' + message;
        }
        if (logElem.children.length) {
            logElem.insertBefore(newElem, logElem.children[0]);
        }
        else {
            logElem.appendChild(newElem);
        }
    }
    return {log: _log};
})().log;

window.onerror = function(err) {
    log("window.onerror: " + err);
};

function connectToSwiftWebViewBridge(callback) {
    if (window.SwiftWebViewBridge) {
        callback(SwiftWebViewBridge);
    } else {
        document.addEventListener('SwiftWebViewBridgeReady', function() {
            callback(SwiftWebViewBridge);
        }, false);
    }
}

connectToSwiftWebViewBridge(function(bridge) {
    bridge.init(function(message, responseCallback) {
        log('JS got a message', message);
        var data = {
            'JS Responds': 'Message received = )'
        };
        responseCallback(data);
    });

    bridge.registerHandlerForSwift('alertReceivedParmas', function(data, responseCallback) {
        log('Swift called alertPassinParmas with', JSON.stringify(data));
        alert(JSON.stringify(data));
        var responseData = {
            'JS Responds': 'alert triggered' 
        };
        responseCallback(responseData);
    });

    window.testSendDataToSwift = function() {
        bridge.sendDataToSwift('Say Hello Swiftly to Swift');
    };
});

function testSendDataToSwiftWithCallback() {
//    alert("test");
    SwiftWebViewBridge.sendDataToSwift('Hi, anybody there?' , function(responseData) {
        alert("got your response: " + JSON.stringify(responseData));
    });
}

function testCallSwiftHandler() {
    data = {
        "name": "小明", 
        "age": "6", 
        "school": "GDUT"
    };
    log('JS is calling printReceivedParmas handler of Swift', data);
    SwiftWebViewBridge.callSwiftHandler("printReceivedParmas", data, null);
}

function testCallSwiftHandlerWithCallback() {
    SwiftWebViewBridge.callSwiftHandler("printReceivedParmas", 
                                        {
                                            "name": "小明",
                                            "age": "6", 
                                            "school": "GDUT"
                                        }, 
                                        function(responseData)
                                        {
                                            log('JS got responds from Swift: ', responseData);
                                        });
}
