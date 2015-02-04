//
//  hotelPotaInfo.m
//  myPota
//
//  Created by Rodrigo Pimentel on 24/11/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "hotelPotaInfo.h"

@implementation hotelPotaInfo

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"hotelPotaInfo dando Warnings");
}

#pragma mark - configNavBar
- (void)configNavBar
{
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_HOTEL_DETAILS
                                     title:nil
                                 backLabel:NAVIGATION_BAR_BACK_TITLE_CLEAR
                                buttonBack:@selector(btnBackScreen:)
                             openSplitMenu:nil
                                backButton:YES];
}

- (IBAction)btnBackScreen:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self configNavBar];
    [super viewWillAppear:animated];
}

#pragma mark - configCabeçalho
- (void)configHeader
{
    InfoPurchase = [[AppFunctions LOAD_INFORMATION:PURCHASE]mutableCopy];
    InfoProduct  = [InfoPurchase objectForKey:PURCHASE_INFO_PRODUCT];
    InfoHotel    = [InfoPurchase objectForKey:HOTEL_INFO];
    
    //star
    NSString *lv = [[NSString stringWithFormat:@"star%@",[InfoHotel objectForKey:@"estrelasHotel"]]
                    stringByReplacingOccurrencesOfString:@"." withString:@""];
    [imgStars     setImage:[UIImage imageNamed:lv]];
    [lblNameHotel setText:[InfoHotel   objectForKey:@"nomeHotel"]];
    [lblCity      setText:[InfoProduct objectForKey:HOTEL_INFO_DESTINY]];
    [lblStreet    setText:[NSString stringWithFormat:@"%@, %@, %@",
                           [InfoHotel   objectForKey:@"enderecoHotel"],
                           [InfoHotel   objectForKey:@"localizacoes"],
                           [InfoHotel   objectForKey:@"zipCodeHotel"]]];
    
    [AppFunctions LOAD_IMAGE_ASYNC:[InfoHotel objectForKey:@"imagemHotel"]  completion:^(UIImage *image) {
        [imgHotel setBackgroundImage:image forState:UIControlStateNormal];
    }];
    
    Linkpictures = [NSString stringWithFormat:WS_URL_HOTEL_IMAGES, [InfoHotel objectForKey:@"codigoHotel"]];
    Linkpictures = [NSString stringWithFormat:WS_URL,WS_URL_POTA_HOTA,Linkpictures];
}

- (void)viewDidLoad
{
    [self configHeader];
    [self configTable];
    [super viewDidLoad];
}

#pragma mark - Button Image
- (IBAction)btnImages:(id)sender {
    [self performSegueWithIdentifier:STORY_BOARD_HOTEL_INFO_PICTURES sender:self];
}

- (NSString *)getNextLink
{
    return Linkpictures;
}

- (bool)isNumeric:(NSString *)checkText
{
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [numberFormatter setNumberStyle:NSNumberFormatterScientificStyle];
    NSNumber* number = [numberFormatter numberFromString:checkText];
    if (number != nil)
        return true;
    return false;
}

- (IBAction)btnMap:(id)sender {
    NSMutableArray *listPins = [NSMutableArray new];
    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake([[InfoHotel objectForKey:@"latitudeHotel"] floatValue],
                                                               [[InfoHotel objectForKey:@"longitudeHotel"] floatValue]);
    
    if ([self isNumeric:[InfoHotel objectForKey:@"latitudeHotel"]] &&
        [self isNumeric:[InfoHotel objectForKey:@"longitudeHotel"]])
    {
        if ([[InfoHotel objectForKey:@"latitudeHotel"] intValue] != 0 &&
            [[InfoHotel objectForKey:@"longitudeHotel"] intValue] != 0)
        {
            NSDictionary *address = @{(NSString *)kABPersonAddressStreetKey      : [InfoHotel objectForKey:@"enderecoHotel"],
                                      (NSString *)kABPersonAddressCityKey        : [InfoHotel objectForKey:@"nomeHotel"],
                                      (NSString *)kABPersonAddressStateKey       : [InfoHotel objectForKey:@"descricaoHotel"],
                                      (NSString *)kABPersonAddressZIPKey         : [InfoProduct objectForKey:HOTEL_INFO_DESTINY],
                                      (NSString *)kABPersonAddressCountryCodeKey : [InfoHotel objectForKey:@"telefoneHotel"]
                                      };
            MKPlacemark *place = [[MKPlacemark alloc]
                                  initWithCoordinate:coords addressDictionary:address];
            MKMapItem *mapItem = [[MKMapItem alloc]
                                  initWithPlacemark:place];
            [mapItem setName:[InfoHotel   objectForKey:@"nomeHotel"]];
            [listPins addObject:mapItem];
        }
    }
    [MKMapItem openMapsWithItems:listPins launchOptions:nil];
}

#pragma mark - Button Purchase
- (IBAction)btnPurchase:(id)sender
{
    [self performSegueWithIdentifier:STORY_BOARD_HOTEL_INFO_ROOMS sender:self];
}

#pragma mark - configTable
- (void)configTable
{
    [tableDataView setBackgroundColor:[UIColor clearColor]];
    [tableDataView setSeparatorColor:[UIColor clearColor]];
}

#pragma mark - Table Number of Sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

#pragma mark - Cell Size
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 0) {
        return 65;
    } else if ([indexPath section] == 1) {
        return 70;
    } else if ([indexPath section] == 2) {
        return 65;
    } else
        return 115;
}

#pragma mark - Table Number of Rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return 0;
    else
        return 0;
}

#pragma mark - Table Cell Custom
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if ([indexPath section] == 0)
    return [self customCell1:tableView cellForRowAtIndexPath:indexPath];
    //    else if ([indexPath section] == 1)
    //        return [self customCell2:tableView cellForRowAtIndexPath:indexPath];
    //    else if ([indexPath section] == 2)
    //        return [self customCell3:tableView cellForRowAtIndexPath:indexPath];
    //    else
    //        return [self customCell4:tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark - Table Cell Section 1
- (UITableViewCell *)customCell1:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    hotelPotaCellAge *cell = [tableView dequeueReusableCellWithIdentifier:@"CellAge" forIndexPath:indexPath];
    //
    //    if (cell.agePicker == nil)
    //    {
    //        cell.agePicker = [AppFunctions HORIZONTAL_PICKER:self
    //                                                    view:cell
    //                                                  center:cell.lblAge.center
    //                                               imageName:@"bgPickerAge"];
    //        [cell.agePicker setTag:[indexPath row]];
    //    }
    //
    //    [cell setBackgroundColor:[UIColor clearColor]];
    //    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    //    [cell.lblAge setText:[NSString stringWithFormat:@"Idade da criança %ld", [indexPath row]+1]];
    //    [cell.agePicker selectRow:[[AgeChildren objectAtIndex:[indexPath row]]intValue]-1 inComponent:0 animated:NO];
    //
    return nil;
}

@end
