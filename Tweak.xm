%hook SBWiFiManager

-(void)_updateCurrentNetwork {
    %log;
    %orig;
}

%end
