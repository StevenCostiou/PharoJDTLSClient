Class {
	#name : 'JDTLSProjectNavigationPresenter',
	#superclass : 'StFileNavigationSystemPresenter',
	#category : 'PharoJDTLSClient',
	#package : 'PharoJDTLSClient'
}

{ #category : 'examples' }
JDTLSProjectNavigationPresenter class >> example [
	<example>
	| presenter |
	presenter := self new.	

	presenter open.
	^ presenter
]

{ #category : 'layout' }
JDTLSProjectNavigationPresenter >> defaultLayout [

	| filesLayout |
	filesLayout := SpBoxLayout newTopToBottom
		               add: self topPaneLayout;
		               yourself.
	^ SpBoxLayout newTopToBottom
		  add: self navigationLayout expand: false;
		  add: filesLayout;
		  yourself
]

{ #category : 'actions' }
JDTLSProjectNavigationPresenter >> filesListAction [

	fileReferenceTable whenActivatedDo: [ :selectedItem |
			selectedItem selectedItem isDirectory ifTrue: [
				self openFolder: selectedItem selectedItem ] ].

	fileReferenceTable whenSelectedDo: [ :aFileReference |
		owner updateSelectedFile: aFileReference ]
]

{ #category : 'initialization' }
JDTLSProjectNavigationPresenter >> initializeFilesTable [

	fileReferenceTable := self newTable.
	fileReferenceTable
		columns: {
				StFileBrowserIconColumn column.
				StFileBrowserNameColumn column };
		sortingBlock: self defaultFileSortBlock;
		whenSelectedItemChangedDo: [ :selectedItem |
			selectedItem ifNotNil: [ self nameText: selectedItem basename ] ]
]

{ #category : 'initialization' }
JDTLSProjectNavigationPresenter >> initializePresenters [

	notebookPreviewer := self instantiate: StNoteBookPreviewerPresenter.
	nameText := self newTextInput.
	filtersDropList := self newDropList.

	self initializeToolbarButtons.
	self initializeNavigationPresenters.
	self initializeFilesTable.
	self initializeFiltersDropList
]

{ #category : 'layout' }
JDTLSProjectNavigationPresenter >> navigationLayout [

	^ SpBoxLayout newLeftToRight
		  vAlignCenter;
		  add: previousButton expand: false;
		  add: nextButton expand: false;
		  addLast: newFolderButton;
		  yourself
]

{ #category : 'accessing - history' }
JDTLSProjectNavigationPresenter >> updateWidgetWithFileReference: aFileReference [
	"A file reference was selected in the receiver or one of its subpresenters, update the file reference table and current directory"

	self currentDirectory: aFileReference.
	self updateFileReferenceTable
]
