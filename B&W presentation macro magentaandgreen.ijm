/*Written 19/5/2020, updated 20/1/2021 to remove montaging and better file names
 * Anna Sims
 * Macro finds the images processed through the Processing macros, merges the correct channels together 
 * Suitable for two channels only
 * Does not create a montage! Designed to be run alongside "b&w montaging macro" to make a montage where the seperate channels are in black and white
 * Assigns the red channel as magenta
 */

//var blue="";
var green="";
var red="";

#@ File (label = "Input directory", style = "directory") input
//#@ File (label = "Output directory", style = "directory") output
#@ String (label = "File suffix", value = ".tif") suffix

// See also Process_Folder.py for a version of this code
// in the Python scripting language.

processFolder(input);

// function to scan folders/subfolders/files to find files with correct suffix
function processFolder(input) {
	list = getFileList(input);
	list = Array.sort(list);
	for (i = 0; i < list.length; i++) {
		if(File.isDirectory(input + File.separator + list[i]))
		print(list[i]);
			processFolder(input + File.separator + list[i]);
		if(endsWith(list[i], suffix))
			processFile(input, list[i]);
	}
}

function processFile(input, file) {
	// Do the processing here by adding your own code.
	// Leave the print statements until things work, then remove them.
open(input + File.separator + file);
title = getTitle();
name = getTitle();
prefix = substring (name, 0, lastIndexOf(name,"_"));
if(indexOf(title, "24") >= 0) {
AssignChannel(); 
} else if (indexOf(title, "48") >= 0) {
	AssignChannel(); 
	} else if (indexOf(title, "72") >= 0){
		AssignChannel();
}
//print("Blue :" + blue + "\nRed: " + red + "\nGreen" + green); 
if ((green != "") && (red != "")){
	run("Merge Channels...", "c6=["+ red +"] c2=["+ green +"] create keep");
	//print("I'm merging the channels!");
	run("RGB Color");
	saveAs("jpg", input + File.separator + prefix + "_merge");
	//print("The title is " + title + "merge");
	//blue = "";
	green = "";
	red = "";
	//print("Blue :" + blue + "\nRed: " + red + "\nGreen" + green);
	close("*");
}
}


function AssignChannel() {
	//print("I'm running the Assign Channel Function");
	//print("I'm opening: " + title);
	if (indexOf(title, "Ch1") >= 0) {
		green = title;
		//print("I've labeled " + title + " as green");
		} else if (indexOf(title, "Ch2") >= 0) {
			red = title;
			//print("I've labeled " + title + " as red"); 
			}
}
//This function finds in the title which channel it belongs to and labels it ready for the merge channels command in line 45
