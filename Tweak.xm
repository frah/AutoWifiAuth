#import "SBWiFiManager.h"

static NSString *settingsFile = @"/var/mobile/Library/Preferences/com.tokcs.autowifiauth.plist";
static NSURL *captive = [NSURL URLWithString:@"http://www.apple.com/library/test/success.html"];

%hook SBWiFiManager

-(void)_updateSignalStrengthTimer {
    %log;
    NSString *curNet = [self currentNetworkName];
    if (curNet != nil) {
        /* Load settings */
        BOOL enabled = NO;
        NSString *ssid  = nil;
        NSString *uname = nil;
        NSString *pass  = nil;
        if ([[NSFileManager defaultManager] fileExistsAtPath:settingsFile]) {
            NSLog(@"[AutoWifiAuth] Setting file found.");
            NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:settingsFile];
            enabled = [[settings objectForKey:@"autowifiauth"] boolValue];
            ssid    = (NSString*)[settings objectForKey:@"ssid"];
            uname   = (NSString*)[settings objectForKey:@"uname"];
            pass    = (NSString*)[settings objectForKey:@"pass"];
        }

        NSLog(@"[AutoWifiAuth] Settings: %@, %@, %@", ssid, uname, pass);
        if (enabled) {
            NSLog(@"[AutoWifiAuth] WifiConnected: %@", curNet);
            if ([curNet isEqualToString:ssid]) {
                NSLog(@"[AutoWifiAuth] start captive");
                NSString *content = [NSString stringWithContentsOfURL:captive encoding:NSUTF8StringEncoding error:nil];
                NSLog(@"captive: %@", content);
            }
        }
    }
    %orig;
}
%end
