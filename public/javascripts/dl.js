var SERVER_PATH = ''
function hl(what) {	what.style.background = "#eee"; }
function nl(what) {	what.style.background = ""; }

function selectTag(obj, tag, level, hits) {

    var sTags = getTags(encodeURI(tag), level);

	browseCourses(sTags);

    highlightSelectedTag(obj,level);

	if (hits > 5 && level < 3)
        showTags(sTags, level + 1);
}

function highlightSelectedTag(obj, level) {
    resetTagColumns(level);

    var nodes = document.getElementById("br" + level).getElementsByTagName("p");
    for(var i=0,ix=nodes.length; i < ix; i++) {
        nodes[i].style.backgroundColor = "";
    }
    obj.style.backgroundColor = "#fd2";
}

function resetTagColumns(level) {
    for(var i=level+1;i<4;i++) {
        document.getElementById("br" + i).innerHTML = "";
    }
}

function getTags(tag, level) {
    if (level == 1) {
        sLevel1Tag = tag;
        sLevel2Tag = '';
        return tag;
    }
    else if (level == 2) {
        sLevel2Tag = tag;
        return sLevel1Tag + "/" + tag;
    }
    else if (level == 3) {
        return sLevel1Tag + "/" + sLevel2Tag + "/" + tag;
    }
}


function showTags(sTags, level) {
    if (sTags.length > 0)
        jQuery("#br" + level).load(SERVER_PATH + 'resources/tags/' + sTags + '?grain_size=course&level=' + level);
}

function searchCourses(sQuery) {
    if (sQuery.length > 0)
        jQuery("#courses").load(SERVER_PATH + 'resources/search?q=' + sQuery + '&grain_size=course');
}

function browseCourses(sTags) {
    if (sTags.length > 0)
        jQuery("#courses").load(SERVER_PATH + 'resources/browse/' + sTags + '?grain_size=course');
}

var lMillis = 0;
var lDelay = 500;
var sCurrentSearch = "";
var sLevel1Tag = "";
var sLevel2Tag = "";

function millis(){return new Date().valueOf();}
function timeToUpdate(){return (millis() - lMillis) > lDelay*.9;}

function filterCourses(sSearchTerms) {
	sSearchTerms = sSearchTerms.trim();
	if (sSearchTerms.length > 2) {
        sSearchTerms = encodeURI(sSearchTerms);
        if (sSearchTerms != sCurrentSearch) {
            lMillis = millis();
            setTimeout("doFilter('" + sSearchTerms + "')", lDelay);
        }
	}
}

function doFilter(sQuery) {
	if (timeToUpdate()) {
        jQuery("#course_browser").hide();
        showBusy();
        sCurrentSearch = sQuery;
        searchCourses(sQuery);
    }
}

function showBusy() {
    jQuery("#courses").html('<div align="center"><img src="/images/spinner.gif" style="vertical-align:middle;"/> Searching</div>');
}

/*
function showDetails(bShow) {
	var link = document.getElementById("details_link");
	link.innerHTML = (bShow ? "<a href=\"#\" onclick=\"showDetails(false); return false;\">Hide Details</a>" : "<a href=\"#\" onclick=\"showDetails(true); return false;\">Show Details</a>");
	var nItem = 1;
	var detail = document.getElementById("detail_" + nItem);
	var aLink = document.getElementById("l_" + nItem);
	while (detail) {
		detail.style.display = (!bShow ? "none" : "block");
		aLink.innerHTML = (bShow ? "Hide Details" : "Show Details");
		nItem++;
		detail = document.getElementById("detail_" + nItem);
		aLink = document.getElementById("l_" + nItem);
	}
}

function toggleItemDetails(nItem) {
	var detail = document.getElementById("detail_" + nItem);
	var bShow = (detail.style.display == "none");
	if (detail) detail.style.display = (!bShow ? "none" : "block");
	var aLink = document.getElementById("l_" + nItem);
	aLink.innerHTML = (bShow ? "Hide Details" : "Show Details");
}
*/
