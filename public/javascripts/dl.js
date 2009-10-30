var SERVER_PATH = ''
/* the mouseover highlighting */
function hl(what) {	what.style.background = "#eee"; }
function nl(what) {	what.style.background = ""; }

function selectTag(obj, tags, level, hits) {
	var q = "t:" + tags.replace(/( )/g, " t:");
	document.getElementById("q").value = q;
    tags = tags.replaceAll(" ","/");
    showCourses(tags);
	for(var i=level;i<4;i++) {
		document.getElementById("br" + i).innerHTML = "";
	}

	if (hits > 5 && level < 4) showTags(tags, level);
	
	var nodes = document.getElementById("br" + (level == 1 ? 1 : level - 1)).getElementsByTagName("p");
	for(var i=0,ix=nodes.length; i < ix; i++) {
		nodes[i].style.backgroundColor = "";
	}
		
	obj.style.backgroundColor = "#fd2";
}

function loadRepositoryList()
{
    new Ajax.Updater('rl', SERVER_PATH + '/feed_list', {asynchronous:true, evalScripts:true, method:'get'});
}

function loadFirstTagColumn()
{
    new Ajax.Updater('br1', SERVER_PATH + '/tags/' + sLanguage, {asynchronous:true, evalScripts:true, method:'get'});
}

function showTags(sTag, nLevel)
{
    new Ajax.Updater('br' + nLevel, SERVER_PATH + '/overlapping_tags/' + sLanguageCode + "/" + nLevel + "/" + sTag, {asynchronous:true, evalScripts:true, method:'get'});
}

function showCourses(sTags)
{
    new Ajax.Updater('courses', SERVER_PATH + '/courses/' + sTags, {asynchronous:true, evalScripts:true, method:'get'});
}

function showDetails(bShow)
{
    var link = document.getElementById("details_link");
    link.innerHTML = (bShow ? "<a href=\"#\" onclick=\"showDetails(false); return false;\">Hide Details</a>" : "<a href=\"#\" onclick=\"showDetails(true); return false;\">Show Details</a>");
    var nItem = 1;
    var detail = document.getElementById("detail_" + nItem);
    var aLink = document.getElementById("l_" + nItem);
    while (detail)
    {
        detail.style.display = (!bShow ? "none" : "block");
        aLink.innerHTML = (bShow ? "Hide Details" : "Show Details");
        nItem++;
        detail = document.getElementById("detail_" + nItem);
        aLink = document.getElementById("l_" + nItem);
    }
}

function toggleItemDetails(nItem)
{
    var detail = document.getElementById("detail_" + nItem);
    var bShow = (detail.style.display == "none");
    if (detail) detail.style.display = (!bShow ? "none" : "block");
    var aLink = document.getElementById("l_" + nItem);
    aLink.innerHTML = (bShow ? "Hide Details" : "Show Details");
}

var lMillis = 0;
var lDelay = 500;
var sCurrentSearch = "";

String.prototype.trim = function() {
	return this.replace(/^\s+|\s+$/g,"");
}
String.prototype.replaceAll = function(strA, strB) {
    return this.replace( new RegExp(strA,"g"), strB );
}    

function millis(){return new Date().valueOf();}

function filterCourses(sSearchTerms)
{
    sSearchTerms = escape(sSearchTerms);
    if (sSearchTerms.trim() != sCurrentSearch)
    {
        sCurrentSearch = sSearchTerms; 
        lMillis = millis();
        setTimeout("doFilter('" + sSearchTerms + "')", lDelay);
    }
}

function doFilter(sSearchTerms)
{
if (sSearchTerms.length < 2) return;
    ct = millis();
    dt = ct - lMillis;
    if (dt > lDelay*.9)
    {
        sSearchTerms = sSearchTerms.replaceAll(" ","/");
        new Ajax.Updater('courses', SERVER_PATH + '/search/' + sSearchTerms + "?language=" + sLanguageCode, {asynchronous:true, evalScripts:true, method:'get'});
    }
}

