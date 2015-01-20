//
//  b8_User_Search_Agent.h
//  myPota
//
//  Created by Rodrigo Pimentel on 09/04/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "choiceVendedorCell.h"
#import "b7_User_Search_Agency.h"

@interface b8_User_Search_Agent : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
{
    IBOutlet UISearchBar        *searchBarData;
    IBOutlet UITableView        *tableViewData;
    b7_User_Search_Agency       *backScreen;
    NSMutableArray              *listVendedores;
    NSMutableArray              *listVendedoresSearch;
    NSMutableDictionary         *listImages;
    Vendedor                    *SelectVendedor;
    NSFetchedResultsController  *fetch;
    NSMutableDictionary         *agenteInfo;
    NSMutableArray              *agenteInfoIdWs;
#pragma mark - textView
    UITextField          *txtViewSelected;
    CGRect               frame;
}

@end
