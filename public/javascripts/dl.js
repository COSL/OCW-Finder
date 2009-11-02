var SERVER_PATH = ''
function hl(what) {	what.style.background = "#eee"; }
function nl(what) {	what.style.background = ""; }

function selectTag(obj, tags, level, hits) {
	showCourses(encodeURI(tags));
	for(var i=level;i<4;i++) {
		document.getElementById("br" + i).innerHTML = "";
	}

	if (hits > 5 && level < 3) showTags(tags, level);

	var nodes = document.getElementById("br" + (level - 1)).getElementsByTagName("p");
	for(var i=0,ix=nodes.length; i < ix; i++) {
		nodes[i].style.backgroundColor = "";
	}
	obj.style.backgroundColor = "#fd2";
}

function clearTagBrowse() {
    document.getElementById("br2").innerHTML = "";
    document.getElementById("br3").innerHTML = "";
    var nodes = document.getElementById("br1").getElementsByTagName("p");
    for(var i=0,ix=nodes.length; i < ix; i++) {
        nodes[i].style.backgroundColor = "";
    }
}


function showTags(sTags, level) {
	if (sTags.length > 0)
        jQuery("#br" + level).load(SERVER_PATH + 'resources/tags/' + sTags + '?grain_size=course&level=' + (level + 1));
}

function showCourses(sTags) {
    if (sTags.length > 0)
        jQuery("#courses").load(SERVER_PATH + 'resources/search?q=' + sTags + '&grain_size=course');
}

var lMillis = 0;
var lDelay = 500;
var sCurrentSearch = "";

function millis(){return new Date().valueOf();}
function timeToUpdate(){return (millis() - lMillis) > lDelay*.9;}

function filterCourses(sSearchTerms) {
	sSearchTerms = escape(sSearchTerms).trim();
	if (sSearchTerms.length > 2 && sSearchTerms != sCurrentSearch) {
		lMillis = millis();
		setTimeout("doFilter('" + sSearchTerms + "')", lDelay);
	}
}

function doFilter(sSearchTerms) {
	if (timeToUpdate()) {
        sCurrentSearch = sSearchTerms;
        showCourses(sSearchTerms);
    }
    clearTagBrowse();
}

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

