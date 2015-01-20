//
//  agentePerfilPota.m
//  myPota
//
//  Created by Rodrigo Pimentel on 08/09/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "c1_Agent_Perfil_Pota.h"

@implementation c1_Agent_Perfil_Pota

- (void)viewDidLoad
{
    [self initData];
    [super viewDidLoad];
}

- (void)initData
{
    dataSeller = [AppFunctions DATA_BASE_ENTITY_LOAD:TAG_USER_SELLER];
    dataAgency = [AppFunctions DATA_BASE_ENTITY_LOAD:TAG_USER_AGENCY];
    
    [self initScreen];
}

- (void)initScreen
{
    [AppFunctions LOAD_IMAGE_ASYNC:[dataSeller objectForKey:TAG_USER_SELLER_FOTO] completion:^(UIImage *image) {
        [SellerImage setImage:image];
    }];
    
    [SellerName   setText:[dataSeller objectForKey:TAG_USER_SELLER_NAME]];
    [SellerAgency setText:[dataAgency objectForKey:TAG_USER_AGENCY_NAME]];
    [SellerMail   setText:[dataSeller objectForKey:TAG_USER_SELLER_MAIL]];
    
    self->mapState = [[self->listState objectForKey:PLIST_STATE_TAG_LOCAL]objectForKey:PLIST_STATE_TAG_STATES];
    self->mapCity  = [[self->listState objectForKey:PLIST_STATE_TAG_LOCAL]objectForKey:PLIST_STATE_TAG_CITYS];
    
    if (self->mapState == NULL)
        self->mapState = [dataSeller objectForKey:TAG_USER_SELLER_UF_NAME];
    if (self->mapCity == NULL)
        self->mapCity = [dataSeller objectForKey:TAG_USER_SELLER_CITY];
    
    if ([[dataAgency objectForKey:TAG_USER_AGENCY_ADRESS] isEqualToString:@""] &&
        [[dataAgency objectForKey:TAG_USER_AGENCY_CEP] isEqualToString:@""] &&
        self->mapState != NULL && self->mapCity != NULL )
        [self->otlMap setEnabled:NO];
}

#pragma mark - willAppear
- (void)viewWillAppear:(BOOL)animated
{
    [self configScreen];
    [super viewWillAppear:animated];
}

#pragma mark -configNavBar
- (void)configScreen
{
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_PERFIL
                                     title:@""
                                superTitle:@""
                                 backLabel:NAVIGATION_BAR_BACK_TITLE_BACK
                                buttonBack:nil
                             openSplitMenu:@selector(menuOpen:)
                                backButton:NO];
}

- (IBAction)menuOpen:(id)sender
{
    [AppMenuView openMenu:self
                   sender:sender];
}

- (IBAction)btnMap:(id)sender
{
    NSString *address = [NSString stringWithFormat:@"%@ %@ %@ %@",
                         [dataAgency objectForKey:TAG_USER_AGENCY_ADRESS],
                         self->mapCity,
                         self->mapState,
                         [dataAgency objectForKey:TAG_USER_AGENCY_CEP]];
    NSString *mapAddress = [@"http://maps.apple.com/?q=" stringByAppendingString:[address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    BOOL result = [[UIApplication sharedApplication] openURL: [NSURL URLWithString: mapAddress]];
    if (!result)
        [AppFunctions LOG_MESSAGE:ERROR_1004_TITLE
                          message:ERROR_1004_MESSAGE
                           cancel:ERROR_BUTTON_CANCEL];
}

- (IBAction)btnClients:(id)sender
{
}

- (IBAction)btnMenu:(id)sender
{
    [AppFunctions POP_SCREEN:self
                  identifier:STORYBOARD_ID_A2
                    animated:YES];
}

@end