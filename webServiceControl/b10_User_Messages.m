//
//  b10_User_Messages.m
//  mypota
//
//  Created by Rodrigo Pimentel on 20/01/15.
//  Copyright (c) 2015 web. All rights reserved.
//

#import "b10_User_Messages.h"

@implementation b10_User_Messages

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"Warning Memory int chat User");
}

- (void)configNavBar
{
    [AppFunctions CONFIGURE_NAVIGATION_BAR:self
                                     image:IMAGE_NAVIGATION_BAR_PERFIL
                                     title:@""
                                superTitle:@""
                                 backLabel:NAVIGATION_BAR_BACK_TITLE_BACK
                                buttonBack:@selector(backScreen:)
                             openSplitMenu:nil
                                backButton:YES];
}

- (IBAction)backScreen:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - configNavBar
- (void)viewWillAppear:(BOOL)animated
{
    message = @"";
    messageList = @[@"Bom dia, como você está?",
                    @"Estou com um problema, poderia me ajudar?",
                    @"Estou com uma duvida sobre "];
    
    [tableViewData setBackgroundColor:[UIColor clearColor]];
    
    [self configNavBar];
    [tableViewData reloadData];
    [super viewWillAppear:animated];
}

#pragma mark - tableView
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [messageList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    b10_Cell_Message *cell = [tableView dequeueReusableCellWithIdentifier:@"messageModel" forIndexPath:indexPath];
    
    [cell.lblText setText:[messageList objectAtIndex:[indexPath row]]];
    [cell.lblText setAdjustsFontSizeToFitWidth:YES];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self newMessage:[messageList objectAtIndex:[indexPath row]]];
}

#pragma mark - new Message
- (IBAction)btnNewMessage:(id)sender
{
    [self newMessage:@""];
}

- (void)newMessage:(NSString *)_message
{
    message = _message;
    [AppFunctions GO_TO_SCREEN:self destiny:SEGUE_B10_TO_B3];
}

- (NSString *)getMessage
{
    return message;
}

@end
