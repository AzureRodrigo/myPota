//
//  packCircuits.h
//  myPota
//
//  Created by Rodrigo Pimentel on 27/10/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "p1_Package_Sel_Type_Cell.h"

@interface p1_Package_Sel_Type : UIViewController <UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate,CustomIOS7AlertViewDelegate>
{
    //Cabeçalho
    IBOutlet UILabel *lblCircuitName;
    IBOutlet UILabel *lblCircuitDescrition;
    IBOutlet UILabel *lblCircuitNumbers;
    IBOutlet UILabel *lblCircuitNumbersLabel;
    IBOutlet UIActivityIndicatorView *loadCircuits;
    
    //Filter
    CustomIOS7AlertView *filterView;
    NSString *wsFilter;
    BOOL     wsFilterUp;
    UIButton *buttonNameAZ;
    UIButton *buttonNameZA;
    
    IBOutlet UISearchBar *searchBarData;
    UITextField          *txtViewSelected;
    BOOL searchSelect;
    
    //List
    IBOutlet UITableView *tableViewData;
    NSDictionary         *listData;
    NSDictionary         *infoType;
    NSArray              *infoCircuits;
    NSMutableArray       *listDataSearch;
    NSMutableDictionary  *listImages;
}




- (IBAction)btnFilter:(id)sender;

@end
