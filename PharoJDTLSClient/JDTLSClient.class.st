Class {
	#name : 'JDTLSClient',
	#superclass : 'PLCClient',
	#instVars : [
		'getURL',
		'putURL',
		'remoteCapabilities',
		'initRequest'
	],
	#category : 'PharoJDTLSClient',
	#package : 'PharoJDTLSClient'
}

{ #category : 'lsp -initialization' }
JDTLSClient class >> onInitializeTrace: trace processId: processId locale: locale clientInfo: clientInfo rootPath: rootPath workspaceFolders: workspaceFolders capabilities: capabilities rootUri: rootUri [

	<jrpc: #initialize>
	self halt.
	self context clientContext: (PLPInitializeParams new
			 trace: trace;
			 processId: processId;
			 locale: locale;
			 clientInfo: clientInfo;
			 rootPath: rootPath;
			 workspaceFolders: workspaceFolders;
			 capabilities: (PLPClientCapabilities from: capabilities);
			 rootUri: rootUri;
			 yourself).
	trace ifNotNil: [ self context traceValue: trace ].
	^ PLSInitializeResult new
]

{ #category : 'api' }
JDTLSClient >> connect [

	getURL := 'http://localhost:5000/' asZnUrl.
	putURL := 'http://localhost:5000/request' asZnUrl
]

{ #category : 'plp - answerLoop' }
JDTLSClient >> extractRequest [

	^ STONJSON fromString: (ZnEasy get: getURL) contents
]

{ #category : 'accessing' }
JDTLSClient >> initRequest [
	^ initRequest
]

{ #category : 'lsp - initialization' }
JDTLSClient >> onInitialize: serverInfo originRequest: originRequest capabilities: capabilities [

	<jrpc: #initialize>
	remoteCapabilities := PLPClientCapabilities raw: capabilities.
	initRequest := originRequest.
	answerLoop := false.
	^ PLSInitializeResult new
]

{ #category : 'lsp - initialization' }
JDTLSClient >> sendInitialize [

	self
		callMethod: 'initialize'
		arguments: (PLPInitializeParams new
				 capabilities: (PLPClientCapabilities new textDocument:
							  (PLPTextDocumentClientCapabilities new
								   inlineCompletion: true;
								   yourself));
				 rootUri: 'file:///Users/steven/Downloads/AOPTest';
				 clientInfo: {
						 (#name -> 'JDTLSClient').
						 (#version -> 'beta') } asDictionary;
				 processId: nil;
				 yourself) asJRPCJSON
		withId: self nextId
]

{ #category : 'private - sending' }
JDTLSClient >> sendRequest: aJRPCRequestObject [

	| request dataStr answer|
	request := self convertJRPCJsonableObjectToJSON:
		           aJRPCRequestObject asJRPCJSON.
	self answerProcessor addHandlerFor: aJRPCRequestObject.

	dataStr := WriteStream on: String new.
	self getHeaderFor: request into: dataStr.
	dataStr nextPutAll: request.

	answer := ZnEasy put: putURL data: (ZnEntity text: dataStr contents).
	self startAnswerLoop
]

{ #category : 'api' }
JDTLSClient >> start [

	self connect.
	self sendInitialize
]

{ #category : 'plp - answerLoop' }
JDTLSClient >> startAnswerLoop [

	answerLoop := true.

	[ answerLoop ] whileTrue: [
			| request |
			[ request := self extractRequest ]
				on: ConnectionTimedOut
				do: [
						answerLoop := false.
						self halt: 'What to do here?' ].
			self handleRequest: request toClient: clientOutStream ]
]
