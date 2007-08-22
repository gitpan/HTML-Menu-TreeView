function ocFolder(id){
var folder = document.getElementById(id).className;
if(folder  ==  'folderOpen'){
document.getElementById(id).className = 'folderClosed';
}else if(folder  ==  'folderClosed'){
document.getElementById(id).className = 'folderOpen';
}else{
var mclass = /(folder.*)Closed/;
var isclosed = mclass.test(folder);
if(isclosed  ==  true){
document.getElementById(id).className = folder.replace(/(folder.*)Closed/,'\$1');
}else{
document.getElementById(id).className = folder.replace(/(folder.*)/,'\$1Closed');
}}}
function ocNode(id){
var folder = document.getElementById(id).className;if(folder  ==  "minusNode"){
document.getElementById(id).className = 'plusNode';
}else if(folder  ==  "plusNode"){
document.getElementById(id).className = 'minusNode';
}else if(folder  ==  "clasicPlusNode"){
document.getElementById(id).className = 'clasicMinusNode';
}else if(folder  ==  "clasicMinusNode"){
document.getElementById(id).className = 'clasicPlusNode';}}
function ocpNode(id){
var folder = document.getElementById(id).className;
if(folder  ==  "lastMinusNode"){
document.getElementById(id).className = 'lastPlusNode';
}else if(folder  ==  "lastPlusNode"){
document.getElementById(id).className = 'lastMinusNode';
}else if(folder  ==  "clasicLastPlusNode"){
document.getElementById(id).className = 'clasicLastMinusNode';
}else if(folder  ==  "clasicLastMinusNode"){
document.getElementById(id).className = 'clasicLastPlusNode';}}
function displayTree(id){
if(document.getElementById(id)){
var e = document.getElementById(id);
var display = e.style.display;
if(display  ==  "none"){
e.style.display = "";
}else if(display  ==  ""){
e.style.display = "none";
}
}
}
function hideArray(i){
    var first = 1;
    var display = '';
    if(window.folders){
        for (var j  =0;j < window.folders[i].length; j++){
            var node =document.getElementById('tr'+window.folders[i][j]);
            if(first){
                display  = node.style.display == 'none' ? '':'none'
                        first = 0;
            }
            var subfolder = document.getElementById(window.folders[i][j]);
            if(subfolder){
                if(subfolder.style.display != display && display == ''){
                    ocFolder(window.folders[i][j]+'.folder');
                    ocNode(window.folders[i][j]+'.node');
                    displayTree(window.folders[i][j]);
                }
            }
            node.style.display = display;
            }
    }
}
