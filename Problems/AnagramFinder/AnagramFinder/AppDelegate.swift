//
//  AppDelegate.swift
//  AnagramFinder
//
//  Created by Rogelio Gudino on 2/14/15.
//  Copyright (c) 2015 Rogelio Gudino. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSTableViewDataSource, NSTableViewDelegate {
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var textScrollView: NSScrollView!
    @IBOutlet weak var findAnagramsButton: NSButton!
    @IBOutlet weak var anagramsTableView: NSTableView!
    var textView: NSTextView! {
        get {
            return self.textScrollView.contentView.documentView as NSTextView
        }
    }
    var currentClusterArray = [String: [String]]()
    
    // MARK: Action Methods
    @IBAction func findAnagrams(sender: AnyObject!) {
        if let string = self.textView.string as String? {
            let words = split(string) { $0 == " "}
            self.currentClusterArray = clusterArrayOfWords(words)
            println(self.currentClusterArray)
            self.anagramsTableView.reloadData()
        }
    }
    
    // MARK: NSTableViewDataSource Methods
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return countElements(self.currentClusterArray.keys)
    }
    
    // MARK: NSTableViewDelegate Methods
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let key = self.currentClusterArray.keys.array[row]
        var numberOfOccurrences = 0
        if let words = self.currentClusterArray[key] {
            numberOfOccurrences = countElements(words)
        }
        
        let tableCellView = tableView.makeViewWithIdentifier("AnagramCell", owner: self) as? NSTableCellView
        tableCellView?.textField?.stringValue = "\(key): \(numberOfOccurrences)"
        return tableCellView
    }
    
    func tableView(tableView: NSTableView, selectionIndexesForProposedSelection proposedSelectionIndexes: NSIndexSet) -> NSIndexSet {
        return NSIndexSet()
    }
}
