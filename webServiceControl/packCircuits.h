//
//  packCircuits.h
//  myPota
//
//  Created by Rodrigo Pimentel on 27/10/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "packCircuitsCell.h"

@interface packCircuits : UIViewController <UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>
{
    //Cabeçalho
    IBOutlet UILabel *lblCircuitName;
    IBOutlet UILabel *lblCircuitDescrition;
    IBOutlet UILabel *lblCircuitNumbers;
    IBOutlet UILabel *lblCircuitNumbersLabel;
    IBOutlet UIActivityIndicatorView *loadCircuits;
    
    //Filter
    IBOutlet UISearchBar *seachBarData;
    UITextField          *txtViewSelected;
    BOOL searchSelect;
    
    //List
    IBOutlet UITableView *tableViewData;
    NSDictionary         *listData;
    NSDictionary         *infoType;
    NSArray              *infoCircuits;
    NSMutableDictionary  *listImages;
}




- (IBAction)btnFilter:(id)sender;

@end
