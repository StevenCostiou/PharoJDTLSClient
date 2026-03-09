Class {
	#name : 'JDTLSCodePresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'fileNavigator',
		'code',
		'language',
		'plcClient',
		'version'
	],
	#category : 'PharoJDTLSClient',
	#package : 'PharoJDTLSClient'
}

{ #category : 'examples' }
JDTLSCodePresenter class >> example [
	<script>
	self new open
]

{ #category : 'styling' }
JDTLSCodePresenter >> applySymbols: listOfSymbols [

	| skinnableText |
	skinnableText := code text asText.
	listOfSymbols do: [ :symbol |
			skinnableText
				addAttribute: (TextColor new color: Color blue)
				from: (code text plsToPosition: symbol range start) + 1
				to: (code text plsToPosition: symbol range end) ]
]

{ #category : 'accessing' }
JDTLSCodePresenter >> code [

	^ code
]

{ #category : 'accessing' }
JDTLSCodePresenter >> code: anObject [

	code := anObject
]

{ #category : 'layout' }
JDTLSCodePresenter >> defaultLayout [

	^ SpBoxLayout newLeftToRight
		  add: fileNavigator expand: false fill: false;
		  add: code expand: true fill: true;
		  yourself
]

{ #category : 'accessing' }
JDTLSCodePresenter >> fileNavigator [

	^ fileNavigator
]

{ #category : 'accessing' }
JDTLSCodePresenter >> fileNavigator: anObject [

	fileNavigator := anObject
]

{ #category : 'initialization' }
JDTLSCodePresenter >> initializePresenter [

	version := 0.
	language := 'python'.
	self startClient.
	fileNavigator := JDTLSProjectNavigationPresenter new.
	fileNavigator updateWidgetWithFileReference:
		((plcClient initRequest params at: #rootUri) readStream
			 upTo: $/;
			 upTo: $/;
			 upToEnd) asFileReference.
	fileNavigator initializeHistoryIteratorWith:
		fileNavigator currentDirectory.
	code := self newText
]

{ #category : 'accessing' }
JDTLSCodePresenter >> language [

	^ language
]

{ #category : 'accessing' }
JDTLSCodePresenter >> language: anObject [

	language := anObject
]

{ #category : 'accessing' }
JDTLSCodePresenter >> plcClient [

	^ plcClient
]

{ #category : 'accessing' }
JDTLSCodePresenter >> plcClient: anObject [

	plcClient := anObject
]

{ #category : 'initialization' }
JDTLSCodePresenter >> startClient [

	plcClient := JDTLSClient new.
	plcClient language: #java.
	plcClient clientInit.
	plcClient start
]

{ #category : 'updating' }
JDTLSCodePresenter >> updateSelectedFile: aFileReference [
	aFileReference isDirectory ifTrue:[^self].
	code text: aFileReference contents
]

{ #category : 'updating' }
JDTLSCodePresenter >> updateTreeNavigationWithFileReference: aFileReference [

	aFileReference isFile ifFalse: [ ^ self ].
	self halt
]

{ #category : 'accessing' }
JDTLSCodePresenter >> version [

	^ version
]

{ #category : 'accessing' }
JDTLSCodePresenter >> version: anObject [

	version := anObject
]

{ #category : 'initialization' }
JDTLSCodePresenter >> windowIsClosing [

	plcClient stop
]
