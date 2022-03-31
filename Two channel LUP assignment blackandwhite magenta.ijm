/* Written 12/5/2020 - debugged 13/5/2020
 *  Anna Sims
 *  Macro loops through multiple folders, removing the background and assigning a LUT 
 * 
 * Macro template to process multiple images in a folder
 * Change tiff to jpg in original text box
 */

#@ File (label = "Input directory", style = "directory") input
//#@ File (label = "Output directory", style = "directory") output
#@ String (label = "File suffix", value = ".tiff") suffix

// See also Process_Folder.py for a version of this code
// in the Python scripting language.

processFolder(input);

// function to scan folders/subfolders/files to find files with correct suffix
function processFolder(input) {
	list = getFileList(input);
	list = Array.sort(list);
	for (i = 0; i < list.length; i++) {
		if(File.isDirectory(input + File.separator + list[i]))
			//print("I'm processing this folder!: ");
			print(list[i]);
			processFolder(input + File.separator + list[i]);
		if(endsWith(list[i], suffix))
			processFile(input, list[i]);
	}
}

function processFile(input, file) {
	// Do the processing here by adding your own code.
	// Leave the print statements until things work, then remove them.
//print("Processing: " + file);
open(input + File.separator + file);
title = getTitle();
name = getTitle();
prefix = substring (name, 0, lastIndexOf(name,"."));
//print("title:" + title);
//print("prefix: " + prefix);
run("Subtract Background...", "rolling=1500 sliding");
//print("I've removed background");
//run("RGB Color");
saveAs("jpg", input + File.separator + prefix + "_b&w");
if(indexOf(title, "Ch1") >= 0) {
	run("Green");
}
//if(indexOf(title, "Ch3") >= 0) {
	//run("Blue");
//}
if(indexOf(title, "Ch2") >= 0) {
	run("Magenta");
}
run("RGB Color");
final_title = input + File.separator + prefix + "_LUT";
//print("Saving as: " + final_title);
saveAs("tif", final_title);
close();
	//print("Processing: " + input + File.separator + file);
	//print("Saving to: " + output);
}
