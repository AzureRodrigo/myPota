//
//  hotelPotaInfo.h
//  myPota
//
//  Created by Rodrigo Pimentel on 24/11/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <AddressBook/AddressBook.h>

@interface hotelPotaInfo : UIViewController <UITableViewDelegate, UITableViewDataSource,MBProgressHUDDelegate>

{
    //cabeçalho Images
    IBOutlet UIButton    *imgHotel;
    IBOutlet UIImageView *imgStars;
    //cabeçalho Labels
    IBOutlet UILabel     *lblNameHotel;
    IBOutlet UILabel     *lblCity;
    IBOutlet UILabel     *lblStreet;
    //ListInfo
    NSDictionary         *InfoPurchase;
    NSDictionary         *InfoProduct;
    NSDictionary         *InfoHotel;
    NSString             *Linkpictures;
    //Table Options
    IBOutlet UITableView *tableDataView;
    MBProgressHUD           *HUD;
    NSString             *IDWS;
    NSMutableDictionary *seller;
}

- (IBAction)btnImages:(id)sender;
- (IBAction)btnMap:(id)sender;
- (IBAction)btnPurchase:(id)sender;

- (NSString *)getNextLink;

- (IBAction)btnMail:(id)sender;

@end
