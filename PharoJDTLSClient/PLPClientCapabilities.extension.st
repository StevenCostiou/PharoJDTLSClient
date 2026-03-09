Extension { #name : 'PLPClientCapabilities' }

{ #category : '*PharoJDTLSClient' }
PLPClientCapabilities class >> raw: aDictionary [

	^ self new
		  general: aDictionary;
		  yourself
]
