//
//  hotePotaRoom.h
//  myPota
//
//  Created by Rodrigo Pimentel on 24/11/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface hotePotaRoom : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    //Header Data Hotel
    IBOutlet UIImageView *HD_imgHotel;
    IBOutlet UIImageView *HD_imgStars;
    IBOutlet UILabel     *HD_lblName;
    IBOutlet UILabel     *HD_lblCity;
    IBOutlet UILabel     *HD_lblStreet;
    
    //Header Data travell
    IBOutlet UILabel     *HD_lblDestiny;
    IBOutlet UILabel     *HD_lblDataGo;
    IBOutlet UILabel     *HD_lblDataEnd;
    IBOutlet UILabel     *HD_lblTravellers;
    IBOutlet UILabel     *HD_lblRoons;
    IBOutlet UILabel     *HD_lblNights;
    
    //Table Options
    IBOutlet UITableView *tableDataView;
    
    //Lists Purchase
    NSMutableDictionary  *dataPurchase;
    NSMutableDictionary  *dataProduct;
    NSMutableDictionary  *dataHotel;
    NSMutableDictionary  *dataWS;
    NSMutableArray       *dataRooms;
}

@end
