//
//  IphoneType.m
//  DSBrowser
//
//  Created by 巩小鹏 on 2016/11/16.
//  Copyright © 2016年 巩小鹏. All rights reserved.
//

#import "IphoneType.h"

@implementation IphoneType

static id _PHO;
+ (instancetype)phone{
    static dispatch_once_t phoToken;
    dispatch_once(&phoToken, ^{
        _PHO = [[[self class] alloc] init];
    });
    return _PHO;
}
-(id)init{
    if (self = [super init]) {
    
    }
    return self;
}

+(NSString *)getUUID
{
        //取出Keychain：
    NSString * strUUID = (NSString *)[GSKeychain passwordForService:__kKeyChainUUID__ account:__kKeyChainAccountToken__];
    
    //首次执行该方法时，uuid为空
    
    if ([strUUID isEqualToString:@""] || strUUID == nil )
    {
        //生成一个uuid的方法
        
//        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
//  
//        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
//        NSString *  result;
        
        CFUUIDRef  uuid;
        
        CFStringRef uuidStr;
        
        uuid = CFUUIDCreate(NULL);
        
        uuidStr = CFUUIDCreateString(NULL, uuid);
        
        strUUID =[NSString stringWithFormat:@"%@",uuidStr];
        CFRelease(uuidStr);
        
        CFRelease(uuid);

        //置空Keychain：
        [GSKeychain deletePasswordForService:__kKeyChainUUID__ account:__kKeyChainAccountToken__];

        //设置Keychain：将该uuid保存到keychain
        [GSKeychain setPassword:strUUID forService:__kKeyChainUUID__ account:__kKeyChainAccountToken__];
        
        
    }
//    GSLog(@"strUUID %@",strUUID);
    return [NSString gsMD5:strUUID];
    
}

+(NSString *)getTid
{
    
    NSString * strUUID;
    CFUUIDRef  uuid;
    
    CFStringRef uuidStr;
    
    uuid = CFUUIDCreate(NULL);
    
    uuidStr = CFUUIDCreateString(NULL, uuid);
    
    strUUID =[NSString stringWithFormat:@"%@",uuidStr];
    CFRelease(uuidStr);
    
    CFRelease(uuid);
    
    return [NSString gsMD5:strUUID];
}


+(NSString *)IDFA
{
    if ([self isIdfa] != NO) {
        return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }else{
        return [self identifierStr];
    }
}
+(BOOL)isIdfa
{
    return  [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled];
}

+(NSString *)identifierStr{
    NSString *identifierStr = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    return identifierStr;
}

+(NSString *)userPhoneName{
    NSString* userPhoneName = [[UIDevice currentDevice] name];
    return userPhoneName;
}
+(NSString*)deviceName{
    NSString* deviceName = [[UIDevice currentDevice] systemName];
    return deviceName;
}
+(NSString *)phoneVersion{
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    return phoneVersion;
}
+(NSString *)phoneModel{
    NSString * phoneModel =  [self iphoneType];
    return phoneModel;
}
+(NSString *)localPhoneModel{
    NSString* localPhoneModel = [[UIDevice currentDevice] localizedModel];
    return localPhoneModel;
}
+(NSDictionary *)infoDictionary{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return infoDictionary;
}
+(NSString *)appCurVersion{
    NSString *appCurVersion = [[self infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return appCurVersion;
}
+(NSString *)appCurVersionNum{
    NSString *appCurVersionNum = [[self infoDictionary] objectForKey:@"CFBundleVersion"];
    return appCurVersionNum;
}
+(NSInteger)isPhoneX{
    if ([[self iphoneType] isEqualToString:@"iPhone Simulator"]) {
        if (__kScreenHeight__ == 812.0) {
            return 1;
        }else{
            return 2;
        }
    }else if([[self iphoneType] isEqualToString:@"iPhone X"]){
         return 1;
    }
        return 2;
}



+(NSString *)iphoneType{
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    
    if ([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    
    if ([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    
    if ([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    
    if ([platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    
    if ([platform isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
    
}



+ (NSString *)defaultUserAgentString

{
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    // Attempt to find a name for this application
    
    NSString *appName = [bundle objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    
    if (!appName) {
        
        appName = [bundle objectForInfoDictionaryKey:@"CFBundleName"];
        
    }
    
    NSData *latin1Data = [appName dataUsingEncoding:NSUTF8StringEncoding];
    
    appName = [[NSString alloc] initWithData:latin1Data encoding:NSISOLatin1StringEncoding];
    
    // If we couldn't find one, we'll give up (and ASIHTTPRequest will use the standard CFNetwork user agent)
    
    if (!appName) {
        
        return nil;
        
    }
    
    NSString *appVersion = nil;
    
    NSString *marketingVersionNumber = [bundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    NSString *developmentVersionNumber = [bundle objectForInfoDictionaryKey:@"CFBundleVersion"];
    
    if (marketingVersionNumber && developmentVersionNumber) {
        
        if ([marketingVersionNumber isEqualToString:developmentVersionNumber]) {
            
            appVersion = marketingVersionNumber;
            
        } else {
            
            appVersion = [NSString stringWithFormat:@"%@ rv:%@",marketingVersionNumber,developmentVersionNumber];
            
        }
        
    } else {
        
        appVersion = (marketingVersionNumber ? marketingVersionNumber : developmentVersionNumber);
        
    }
    
    NSString *deviceName;
    
    NSString *OSName;
    
    NSString *OSVersion;
    
    NSString *locale = [[NSLocale currentLocale] localeIdentifier];
    
#if TARGET_OS_IPHONE
    
    UIDevice *device = [UIDevice currentDevice];
    
    deviceName = [device model];
    
    OSName = [device systemName];
    
    OSVersion = [device systemVersion];
    
#else
    
    deviceName = @"Macintosh";
    
    OSName = @"Mac OS X";
    
    // From http://www.cocoadev.com/index.pl?DeterminingOSVersion
    
    // We won't bother to check for systems prior to 10.4, since ASIHTTPRequest only works on 10.5+
    
    OSErr err;
    
    SInt32 versionMajor, versionMinor, versionBugFix;
    
    err = Gestalt(gestaltSystemVersionMajor, &versionMajor);
    
    if (err != noErr) return nil;
    
    err = Gestalt(gestaltSystemVersionMinor, &versionMinor);
    
    if (err != noErr) return nil;
    
    err = Gestalt(gestaltSystemVersionBugFix, &versionBugFix);
    
    if (err != noErr) return nil;
    
    OSVersion = [NSString stringWithFormat:@"%u.%u.%u", versionMajor, versionMinor, versionBugFix];
    
#endif
//    [MaqueTool newUserAgent:[HistoryData ua]];
//    NSMutableString *oldAgent = [NSMutableString stringWithString:[[UIWebView new] stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"]];
//    // Takes the form "My Application 1.0 (Macintosh; Mac OS X 10.5.7; en_GB)"
//    NSString *newAgent1 = [oldAgent stringByAppendingString:[HistoryData ua]];

//    return newAgent1;
//    if ([NewModel newModel].userAgentNew ) {
//        
//    }else{
//    

        return  [NSString stringWithFormat:@"%@ (%@; %@ %@; %@) ", appVersion, deviceName, OSName, OSVersion, locale];

    
    
    
}


//获取设备当前网络IP地址
+(NSString *)getIPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4 ?
    @[ /*IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6,*/ IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ /*IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4,*/ IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
//    NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}

//获取所有相关IP信息
+(NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}




+ (NSString *)getMacAddress
{
int         mgmtInfoBase[6];
char        *msgBuffer = NULL;
size_t       length;
unsigned char    macAddress[6];
struct if_msghdr  *interfaceMsgStruct;
struct sockaddr_dl *socketStruct;
NSString      *errorFlag = NULL;

// Setup the management Information Base (mib)
mgmtInfoBase[0] = CTL_NET;    // Request network subsystem
mgmtInfoBase[1] = AF_ROUTE;    // Routing table info
mgmtInfoBase[2] = 0;
mgmtInfoBase[3] = AF_LINK;    // Request link layer information
mgmtInfoBase[4] = NET_RT_IFLIST; // Request all configured interfaces

// With all configured interfaces requested, get handle index
if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
errorFlag = @"if_nametoindex failure";
else
{
    // Get the size of the data available (store in len)
    if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
        errorFlag = @"sysctl mgmtInfoBase failure";
    else
    {
        // Alloc memory based on above call
        if ((msgBuffer = malloc(length)) == NULL)
            errorFlag = @"buffer allocation failure";
        else
        {
            // Get system information, store in buffer
            if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
                errorFlag = @"sysctl msgBuffer failure";
        }
    }
}

// Befor going any further...
if (errorFlag != NULL)
{
    NSLog(@"Error: %@", errorFlag);
    return errorFlag;
}

// Map msgbuffer to interface message structure
interfaceMsgStruct = (struct if_msghdr *) msgBuffer;

// Map to link-level socket structure
socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);

// Copy link layer address data in socket structure to an array
memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);

// Read from char array into a string object, into traditional Mac address format
NSString *macAddressString = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x",
                              macAddress[0], macAddress[1], macAddress[2],
                              macAddress[3], macAddress[4], macAddress[5]];
NSLog(@"Mac Address: %@", macAddressString);

// Release the buffer memory
free(msgBuffer);
      return macAddressString;
}
+(NSString *)getcarrierName
{
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
    NSString *currentCountry=[carrier carrierName];
    NSString * MCCMNC;
    if ([currentCountry isEqualToString:@"中国移动"]) {
        MCCMNC = @"46000";
    }else if([currentCountry isEqualToString:@"中国联通"]){
        MCCMNC = @"46001";
    }else if([currentCountry isEqualToString:@"中国电信"]){
        MCCMNC = @"46003";
    }
//    NSLog(@"[carrier isoCountryCode]==%@,[carrier allowsVOIP]=%d,[carrier mobileCountryCode=%@,[carrier mobileCountryCode]=%@",[carrier isoCountryCode],[carrier allowsVOIP],[carrier mobileCountryCode],[carrier mobileNetworkCode]);
    return MCCMNC;
}

- (NSDictionary *)SSIDInfo

{
    
    NSArray *ifs = (__bridge_transfer NSArray *)CNCopySupportedInterfaces();
    
    NSDictionary *info = nil;
    
    for (NSString *ifnam in ifs) {
        
        info = (__bridge_transfer NSDictionary *)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        
        if (info && [info count]) {
            
            break;
            
        }
        
    }
    
    return info;
    
}

+(NSString *)IphonePPI
{
    NSString * ppiStr ;
    CGFloat ppi;
    // 设备宽度
 CGFloat widthGS = [UIScreen mainScreen].bounds.size.width;
    // 设备高度
 CGFloat heightGS = [UIScreen mainScreen].bounds.size.height;
    
    ppi = sqrt(pow(widthGS*2,2)+pow(heightGS*2, 2));
    if (isiPhone2Gor3Gor3Gs) {
//        NSLog(@"这是 iPhone3 或 3G 或 3Gs") ;
        ppiStr = [NSString stringWithFormat:@"%d",(int)ceil(ppi/3.5)];

    } else if (isiPhone4or4s) {
        ppiStr = [NSString stringWithFormat:@"%d",(int)ceil(ppi/3.5)];

//        NSLog(@"这是 iPhone4 或 4s");
    } else if (isiPhone5or5sor5c) {
        ppiStr = [NSString stringWithFormat:@"%d",(int)ceil(ppi/4)];

//        NSLog(@"这是 iPhone5 或 5s 或 5c") ;
    }else if (isiPhone6or6s) {
        
//        NSLog(@"这是 iPhone6 或 6s");
        
        ppiStr = [NSString stringWithFormat:@"%d",(int)ceil(ppi/4.7)];

    }else if (isiPhone6plusor6splus) {
        ppiStr = [NSString stringWithFormat:@"%d",(int)ceil(ppi/5.5)];

//        NSLog(@"这是 iPhone6plus 或6splus");
    }
    
    return ppiStr;
}

+(NSDictionary *)getInFoSchemes
{
     NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *dictInfo = [NSDictionary dictionaryWithContentsOfFile:path];
    GSLog(@"%@",dictInfo[@"LSApplicationQueriesSchemes"]);
    return dictInfo;
}

+(void)p{

}



@end
