/*
 function openPlayerDetail(playerName)
 {
 var param ="http://playerDetail.php?sn=%E7%BD%91%E9%80%9A%E5%9B%9B&sk=523987@11T&target="+encodeURI(playerName) + "&timestamp=" + Math.round(new Date().getTime()/1000);
 var myurl="ffapp:"+"alert"+":"+param;
 document.location = myurl;
 };*/

function openPage(pageURL)
{
    document.location = pageURL;
};


var lolbox=
{
    'id': 1,
    'openWebViewActivity': function(param) {
        lolbox.sendCommand("alert",param);
    },
    'sendCommand': function(cmd,param) {
        var url="ffapp:"+cmd+":"+param;
        document.location = url;
    }
};

function add_css(str_css) { //Copyright @ rainic.com
    try { //IE下可行
        var style = document.createStyleSheet();
        style.cssText = str_css;
    }
    catch (e) { //Firefox,Opera,Safari,Chrome下可行
        var style = document.createElement("style");
        style.type = "text/css";
        style.textContent = str_css;
        document.getElementsByTagName("HEAD").item(0).appendChild(style);
    }
}

add_css(".action-bar{visibility:hidden;}");
add_css(".page-title-head{visibility:hidden;}");
add_css(".page-title-head{display:null}");

/*feedback*/
add_css(".tc-header{min-height:0px;}");

