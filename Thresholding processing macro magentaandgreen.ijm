/*Created by Anna Sims, 20/1/2020
 * Macro creates a montage using black and white images and the merge images from B&W presentation macros
 * Only suitable for two channels
 * Adds scale bar 
 */

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
	//print("file is" + file);
	open(input + File.separator + file);
	title = getTitle();
	name = getTitle();
	prefix = substring (name, 0, lastIndexOf(name,"_"));
	//print("prefix is: " + prefix);
	run("Subtract Background...", "rolling=1500 sliding");
	setAutoThreshold("Default dark");
	run("Threshold...");
	call("ij.plugin.frame.ThresholdAdjuster.setMode", "B&W");
	run("Convert to Mask");
	//print("I've thresholded the the channels!");
	saveAs("jpg", input + File.separator + prefix + "_b&w");
	//print("I've saved the file as: " + input + File.separator + prefix + "_threshold");
	if(indexOf(title, "Ch1") >= 0) {
	run("Green");
	}
		if(indexOf(title, "Ch2") >= 0) {
		run("Magenta");
		}
run("RGB Color");
final_title = input + File.separator + prefix + "_LUT";
//print("Saving as: " + final_title);
saveAs("tif", final_title);
	close("*");
}
