//
//  AppFunctions.m
//  myPota
//
//  Created by Rodrigo Pimentel on 08/05/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "AppFunctions.h"

@implementation AppFunctions

+ (NSDictionary *)DATA_BASE_ENTITY_LOAD:(NSString *)_entity
{
    AppDelegate *appDelegate  = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:_entity inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;

    NSArray *result = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error)
    {
        NSLog(@"Unable to execute fetch request.");
        NSLog(@"%@, %@", error, error.localizedDescription);
        return nil;
    } else {
        if (result.count > 0)
        {
            NSManagedObject *data = (NSManagedObject *)[result objectAtIndex:0];
            NSArray *keys      = [[[data entity] attributesByName] allKeys];
            return [data dictionaryWithValuesForKeys:keys];
        }
        return nil;
    }
}

+ (BOOL)DATA_BASE_ENTITY_REMOVE:(NSString *)_entity
{
    AppDelegate *appDelegate  = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:_entity
                                              inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    NSArray *result = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if ([result count] > 0)
    {
        NSManagedObject *person = (NSManagedObject *)[result objectAtIndex:0];
        [appDelegate.managedObjectContext deleteObject:person];
        NSError *deleteError = nil;
        if (![person.managedObjectContext save:&deleteError])
        {
            NSLog(@"Unable to save managed object context.");
            NSLog(@"%@, %@", deleteError, deleteError.localizedDescription);
            return YES;
        }
    }
    return NO;
}

+ (NSFetchedResultsController *)DATA_BASE_ENTITY_GET:(NSFetchedResultsController *)_fetchedResultsController delegate:(id)_delegate entity:(NSString *)_entity sort:(NSString *)_sort
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    AppDelegate *appDelegate  = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:_entity
                                              inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:_sort ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:appDelegate.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = _delegate;
    NSError *error = nil;
    
    _fetchedResultsController = aFetchedResultsController;
    
    if (![_fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}

+ (NSManagedObject *)DATA_BASE_ENTITY_ADD:(NSFetchedResultsController *)_fetchedResultsController
{
    NSManagedObjectContext *context = [_fetchedResultsController managedObjectContext];
    NSEntityDescription    *entity  = [[_fetchedResultsController fetchRequest] entity];
    return [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
}

+ (BOOL)DATA_BASE_ENTITY_SAVE:(NSFetchedResultsController *)_fetchedResultsController
{
    NSManagedObjectContext *context = [_fetchedResultsController managedObjectContext];
    NSError *error = nil;
    if (![context save:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
        return NO;
    } else {
        return YES;
    }
    return NO;
}

+ (void)APP_LOGOFF
{
    //desregistrar aparelho!
    
    [AppFunctions DATA_BASE_ENTITY_REMOVE:TAG_USER_TYPE];
    [AppFunctions DATA_BASE_ENTITY_REMOVE:TAG_USER_PERFIL];
    [AppFunctions DATA_BASE_ENTITY_REMOVE:TAG_USER_SELLER];
    [AppFunctions DATA_BASE_ENTITY_REMOVE:TAG_USER_AGENCY];
}

+ (void)APP_SELECT_SELLER
{
    [AppFunctions DATA_BASE_ENTITY_REMOVE:TAG_USER_SELLER];
    [AppFunctions DATA_BASE_ENTITY_REMOVE:TAG_USER_AGENCY];
}

+ (NSString *)GET_TOKEN_DEVICE
{
    AppDelegate *appDelegate  = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.tokenPhone;
}

#pragma mark - MESSAGE_POP_UP
+ (void)LOG_MESSAGE:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:cancel
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark - NAVIGATION_BAR
+ (UIViewController *)CONFIGURE_NAVIGATION_BAR:(UIViewController *)screen image:(NSString *)imageName title:(NSString *)title superTitle:(NSString *)superTitle backLabel:(NSString *)backLabel buttonBack:(SEL)buttonBack openSplitMenu:(SEL)openSplitMenu backButton:(BOOL)backButton
{
    UIImage *image = [[UIImage imageNamed:imageName]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10) resizingMode:UIImageResizingModeStretch];
    [[screen.navigationController navigationBar] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    CGFloat scale = 1;
    CGFloat cy = 44.0 - ( 44.0 * scale );
    CGRect frame = CGRectMake(0, 0, screen.navigationController.view.frame.size.width * .2f, 44);
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    [button addTarget:screen action:buttonBack forControlEvents:UIControlEventTouchUpInside];
    [button setContentMode: UIViewContentModeCenter];
    [button setImage:[UIImage imageNamed:IMAGE_NAVIGATION_BAR_BACK_BUTTON] forState:UIControlStateNormal];
    
    if (![backLabel isEqualToString:@""]) {
        [button setTitle:backLabel forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont fontWithName:FONT_NAME size:10]];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    
    UIBarButtonItem *backBarBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
    [screen.navigationItem setLeftBarButtonItem:backBarBtn];
    
    screen.navigationController.navigationBar.transform = CGAffineTransformScale( CGAffineTransformMakeTranslation( 0, -cy / 2.0 ), 1.0, scale );
    
    if (openSplitMenu != NULL)
    {
        CGRect frame = CGRectMake(0, 0, 40, 44);
        UIButton* button = [[UIButton alloc] initWithFrame:frame];
        [button setBackgroundImage:[UIImage imageNamed:@"btnOption"] forState:UIControlStateNormal];
        [button addTarget:screen action:openSplitMenu forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [screen.navigationItem setRightBarButtonItem:barButtonItem];
    }
    
    [screen.navigationItem.leftBarButtonItem.customView setHidden:!backButton];
    
    return nil;
}

#pragma mark - NAVIGATION_BAR_CALENDAR
+ (UIViewController *)CONFIGURE_NAVIGATION_BAR_CALENDAR:(UIViewController *)screen image:(NSString *)imageName backLabel:(NSString *)backLabel buttonBack:(SEL)buttonBack
{
    UIImage *image = [[UIImage imageNamed:imageName]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10) resizingMode:UIImageResizingModeStretch];
    [[screen.navigationController navigationBar] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    CGFloat scale = 1;
    CGFloat cy = 44.0 - ( 44.0 * scale );
    CGRect frame = CGRectMake(0, 0, screen.navigationController.view.frame.size.width * .2f, 44);
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    [button addTarget:screen action:buttonBack forControlEvents:UIControlEventTouchUpInside];
    [button setContentMode: UIViewContentModeCenter];
    [button setImage:[UIImage imageNamed:IMAGE_NAVIGATION_BAR_BACK_BUTTON] forState:UIControlStateNormal];
    
    if (![backLabel isEqualToString:@""]) {
        [button setTitle:backLabel forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont fontWithName:FONT_NAME size:10]];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    
    UIBarButtonItem *backBarBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
    [screen.navigationItem setLeftBarButtonItem:backBarBtn];
    screen.navigationController.navigationBar.transform = CGAffineTransformScale( CGAffineTransformMakeTranslation( 0, -cy / 2.0 ), 1.0, scale );
    
    return nil;
}

+ (UILabel *)NEW_LABEL:(CGRect)frame size:(float)size font:(NSString *)font alignment:(int)alignment color:(UIColor *)color text:(NSString *)text
{
    UILabel *object = [[UILabel alloc] initWithFrame:frame];
    [object setFont:[UIFont fontWithName:font size:size]];
    [object setTextAlignment:alignment];
    [object setTextColor:color];
    [object setText:text];
    return object;
}

#pragma mark - SEARCH_BAR
+ (void)CONFIGURE_SEARCH_BAR:(UISearchBar *)searchBar delegate:(id)_delegate done:(SEL)_done cancel:(SEL)_cancel
{
    [AppFunctions CONFIGURE_SEARCH_BAR_VISUAL:searchBar];
    [AppFunctions SEARCH_BAR_ADD_KEYBOARD_BAR:@[searchBar]
                                     delegate:_delegate
                                         done:_done
                                       cancel:_cancel];
}

+ (void)CONFIGURE_SEARCH_BAR_VISUAL:(UIView *)searchBar
{
    if (!searchBar)
        return;
    
    for (UIView *subview in searchBar.subviews)
        [AppFunctions CONFIGURE_SEARCH_BAR_VISUAL:subview];
    
    if ([searchBar conformsToProtocol:@protocol(UITextInputTraits)])
    {
        UITextField *textView = (UITextField *)searchBar;
        if ([textView respondsToSelector:@selector(setClearButtonMode:)])
            [textView setClearButtonMode:UITextFieldViewModeNever];
    }
    [AppFunctions CALCEL_BUTTON_SEARCHBAR:searchBar];
}

+ (void)CALCEL_BUTTON_SEARCHBAR:(UIView *)controller
{
    UISearchBar *tmp = (UISearchBar *)controller;
    
    for (UIView *subView in tmp.subviews){
        if([subView isKindOfClass:[UIButton class]]){
            [(UIButton*)subView setTitle:@"Cancelar" forState:UIControlStateNormal];
        }
    }
    
    for (UIView *subView in tmp.subviews){
        if ([subView isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subView removeFromSuperview];
            break;
        }
        if ([subView isKindOfClass:NSClassFromString(@"_UISearchBarSearchFieldBackgroundView")]) {
            subView.layer.borderWidth = 1;
            subView.layer.cornerRadius = 10.f;
            subView.layer.masksToBounds = YES;
            subView.layer.borderColor = [[UIColor grayColor] CGColor];
            break;
        }
    }
}

#pragma mark - BACK_SCREEN
+ (UIViewController *)BACK_SCREEN:(UIViewController *)screen number:(int)number
{
    NSInteger numberOfViewControllers = [screen.navigationController.viewControllers indexOfObject:screen];
    if (numberOfViewControllers < number)
        return nil;
    else
        return [screen.navigationController.viewControllers objectAtIndex:numberOfViewControllers - number];
}

#pragma mark - Data Synchron
+ (void)SAVE_INFORMATION:(NSDictionary *)_info tag:(NSString *)_tag
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:[NSKeyedArchiver archivedDataWithRootObject:_info] forKey:_tag];
    [def synchronize];
}

+ (NSDictionary *)LOAD_INFORMATION:(NSString *)_tag
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSData *data = [def objectForKey:_tag];
    return[NSKeyedUnarchiver unarchiveObjectWithData:data];
}

+ (void)CLEAR_INFORMATION
{
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
}

#pragma mark - LOAD_IMAGE_ASYNC
+ (dispatch_queue_t)LOAD_IMAGE_ASYNC:(NSString *)link completion:(void (^)(UIImage *image))block
{
    NSString *MyURL = [link stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0ul);
    dispatch_async(queue, ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:MyURL]];
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (image != NULL){
                if (block != NULL) {
                    block (image);
                }
            }
        });
    });
    
    return queue;
}

#pragma mark - PLIST_LOAD
+ (NSMutableDictionary *)PLIST_LOAD:(NSString *)name
{
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:name];
    return [[NSMutableDictionary alloc] initWithContentsOfFile:path];
}

#pragma mark - PLIST_LOAD
+ (NSMutableArray *)PLIST_ARRAY_LOAD:(NSString *)name
{
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:name];
    return [[NSMutableArray alloc] initWithContentsOfFile:path];
}

#pragma mark - PLIST_SAVE
+ (NSString *)PLIST_SAVE:(NSString *)name
{
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:name];
}

#pragma mark - PLIST_PATH
+ (NSMutableDictionary *)PLIST_PATH:(NSString *)name type:(NSString *)type
{
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    return [[[NSMutableDictionary alloc] initWithContentsOfFile:sourcePath] mutableCopy];
    
}
#pragma mark - PLIST_PATH
+ (NSMutableArray *)PLIST_ARRAY_PATH:(NSString *)name type:(NSString *)type
{
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    return [[[NSMutableArray alloc] initWithContentsOfFile:sourcePath] mutableCopy];
    
}

#pragma mark - APPLY_COLOR
+ (UIImage *)APPLY_COLOR:(UIImage *)image color:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [UIImage imageWithCGImage:img.CGImage
                               scale:1.0 orientation: UIImageOrientationDownMirrored];
}

#pragma mark - VALID_CPF
+ (BOOL)VALID_CPF:(NSString*) str
{
    NSUInteger i, firstSum, secondSum, firstDigit, secondDigit, firstDigitCheck, secondDigitCheck;
    if(str == nil) return NO;
    
    if ([str length] != 11) return NO;
    
    if (([str isEqual:@"00000000000"])
        || ([str isEqual:@"11111111111"])
        || ([str isEqual:@"22222222222"])
        || ([str isEqual:@"33333333333"])
        || ([str isEqual:@"44444444444"])
        || ([str isEqual:@"55555555555"])
        || ([str isEqual:@"66666666666"])
        || ([str isEqual:@"77777777777"])
        || ([str isEqual:@"88888888888"])
        || ([str isEqual:@"99999999999"]))
        return NO;
    
    firstSum = 0;
    for (i = 0; i <= 8; i++)
        firstSum += [[str substringWithRange:NSMakeRange(i, 1)] intValue] * (10 - i);
    
    if (firstSum % 11 < 2)
        firstDigit = 0;
    else
        firstDigit = 11 - (firstSum % 11);
    
    secondSum = 0;
    for (i = 0; i <= 9; i++) {
        secondSum = secondSum + [[str substringWithRange:NSMakeRange(i, 1)] intValue] * (11 - i);
    }
    
    if (secondSum % 11 < 2)
        secondDigit = 0;
    else
        secondDigit = 11 - (secondSum % 11);
    
    firstDigitCheck = [[str substringWithRange:NSMakeRange(9, 1)] intValue];
    secondDigitCheck = [[str substringWithRange:NSMakeRange(10, 1)] intValue];
    
    if ((firstDigit == firstDigitCheck) && (secondDigit == secondDigitCheck))
        return YES;
    return NO;
}

#pragma mark - SET_SCROLL
+ (void)SET_SCROLL:(UIScrollView *)_view frame:(CGRect)_frame center:(CGPoint)_center
{
    [_view setContentSize:CGSizeMake(_view.bounds.size.width, _center.y + _frame.size.height / 2)];
}

#pragma mark - VALID_MAIL
+ (BOOL)VALID_MAIL:(NSString *)email
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark - VALID_NUMBER
+ (BOOL)VALID_NUMBER:(NSString *)number
{
    //    NSPredicate *numberPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES '^[0-9]+$'"];
    //    return [numberPredicate evaluateWithObject:number];
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [numberFormatter setNumberStyle:NSNumberFormatterScientificStyle];
    NSNumber* valid = [numberFormatter numberFromString:number];
    if (valid != nil)
        return true;
    return false;
}

+ (void)SHOW_OPTIONS:(UIViewController *)main title:(NSString *)_title message:(NSString *)_message cancel:(NSString *)_cancel confirm:(NSString *)_confirm
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_title
                                                    message:_message
                                                   delegate:main
                                          cancelButtonTitle:_cancel
                                          otherButtonTitles:_confirm,nil];
    [alert show];
}


+ (int)DIFERENCE_DATE_IN_DAYS:(NSDateComponents *)start end:(NSDateComponents *)end
{
    double SECONDS_TO_DAY = 60 * 60 * 24;
    double TIME           = [end.date timeIntervalSinceDate:start.date];
    
    return TIME/SECONDS_TO_DAY;
}

+ (int)DIFERENCE_DATE_IN_DAYS_DATE:(NSString *)start end:(NSString *)end
{
    
    NSDateFormatter *formatDateTMP   = [[NSDateFormatter alloc] init];
    NSLocale *localeTMP              = [[NSLocale alloc] initWithLocaleIdentifier:@"pt_Br"];
    [formatDateTMP setLocale:localeTMP];
    
    [formatDateTMP setDateFormat:@"dd/MM/yyyy"];
    
    NSDate *startD = [formatDateTMP dateFromString:start];
    NSDate *endD   = [formatDateTMP dateFromString:end];
    
    double TIME           = [endD timeIntervalSinceDate:startD];
    
    double SECONDS_TO_DAY = 60 * 60 * 24;
    return TIME/SECONDS_TO_DAY;
}

#pragma mark - keyBoard init
+ (void)INIT_KEYBOARD_CENTER:(UIViewController *)sender willShow:(SEL)willShow willHide:(SEL)willHide
{
    [[NSNotificationCenter defaultCenter] addObserver:sender selector:willShow name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:sender selector:willHide name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - textView center screen
+ (void)MOVE_SET_DATA:(UIViewController *)sender notification:(NSNotification *)notification scrollView:(UIScrollView *)scrollView textField:(UITextField *)textField goCenter:(BOOL)goCenter
{
    CGSize  keyboardSize  = [[notification.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    double  animationTime = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGPoint viewCenter    = scrollView.center;
    float   extraSize     = textField.frame.origin.y - (textField.frame.size.height + keyboardSize.height);
    if (extraSize > textField.frame.origin.y)
        extraSize = extraSize + textField.frame.origin.y;
    
    float centerView    = scrollView.frame.origin.y + textField.frame.origin.y + textField.frame.size.height;
    float centeKeyboard = sender.view.frame.size.height - keyboardSize.height;
    
    NSLog(@"centerView:     %f", centerView);
    NSLog(@"centerKeyboard: %f", centeKeyboard);
    
    if (centerView >= centeKeyboard && goCenter)
    {
        animationTime += .2f;
        [AppFunctions MOVE_VIEW_UP:YES scrollView:scrollView animationTime:animationTime center:viewCenter extraSize:extraSize];
    }
    else if (centerView < centeKeyboard && !goCenter)
    {
        animationTime -= .1f;
        [AppFunctions MOVE_VIEW_UP:NO scrollView:scrollView animationTime:animationTime center:viewCenter extraSize:extraSize];
    }
}

#pragma mark - textView center screen
+ (void)MOVE_SET_DATA:(UIViewController *)sender notification:(NSNotification *)notification scrollView:(UIScrollView *)scrollView textField:(UITextField *)textField posField:(CGPoint)posField goCenter:(BOOL)goCenter
{
    CGSize  keyboardSize  = [[notification.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    double  animationTime = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGPoint viewCenter    = scrollView.center;
    float   extraSize     = posField.y - (textField.frame.size.height + keyboardSize.height);
    if (extraSize > textField.frame.origin.y)
        extraSize = extraSize + textField.frame.size.height * 1.5;
    
    float centerView    = scrollView.frame.origin.y + posField.y + textField.frame.size.height;
    float centeKeyboard = sender.view.frame.size.height - keyboardSize.height;
    
    NSLog(@"centerView: %f, centerKeyboard: %f, up?: %d, extra size: %f", centerView, centeKeyboard, goCenter, extraSize);
    
    if (centerView >= centeKeyboard && goCenter)
    {
        animationTime += .2f;
        [AppFunctions MOVE_VIEW_UP:YES scrollView:scrollView animationTime:animationTime center:viewCenter extraSize:extraSize];
    }
    else if (!goCenter && scrollView.frame.origin.y < 0)
    {
        NSLog(@"%f",extraSize);
        NSLog(@"%f",centerView - extraSize);
        if (centerView > centeKeyboard)
            //            extraSize = extraSize + centerView - centeKeyboard;
            animationTime -= .1f;
        [AppFunctions MOVE_VIEW_UP:NO scrollView:scrollView animationTime:animationTime center:viewCenter extraSize:extraSize];
    }
}

#pragma mark - keyBoard moveExecute
+ (void)MOVE_VIEW_UP:(BOOL)moveUp scrollView:(UIScrollView *)scrollView animationTime:(double)animationTime center:(CGPoint)center extraSize:(float)extraSize
{
    if (moveUp)
        extraSize = extraSize * -1;
    
    center = CGPointMake(center.x, CGRectGetMidY(scrollView.frame) + extraSize);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationTime];
    scrollView.center = center;
    [UIView commitAnimations];
}

#pragma mark - keyBoard finish
+ (void)FINISH_KEYBOARD_CENTER:(UIViewController *)sender
{
    [[NSNotificationCenter defaultCenter] removeObserver:sender];
    [sender.view endEditing:YES];
}

+ (BOOL)CEP_VALIDATION:(NSString *)code
{
    return NO;
}

#pragma mark - scroll cell to center
+ (void)SCROLL_RECT_TO_CENTER:(CGRect)visibleRect animated:(BOOL)animated tableView:(UITableView *)_tableView
{
    CGRect centeredRect = CGRectMake(visibleRect.origin.x + visibleRect.size.width/2.0 - _tableView.frame.size.width/2.0,
                                     visibleRect.origin.y + visibleRect.size.height/2.0 - _tableView.frame.size.height/2.0,
                                     _tableView.frame.size.width,
                                     _tableView.frame.size.height);
    [_tableView scrollRectToVisible:centeredRect
                           animated:animated];
}

#pragma mark - scroll cell to center
+ (void)SCROLL_VIEW_RECT_TO_CENTER:(CGRect)visibleRect animated:(BOOL)animated view:(UIViewController *)_view
{
    //    CGRect centeredRect = CGRectMake(visibleRect.origin.x + visibleRect.size.width/2.0 - _tableView.frame.size.width/2.0,
    //                                     visibleRect.origin.y + visibleRect.size.height/2.0 - _tableView.frame.size.height/2.0,
    //                                     _tableView.frame.size.width,
    //                                     _tableView.frame.size.height);
    //    [_tableView scrollRectToVisible:centeredRect
    //                           animated:animated];
}

#pragma mark - go to screen
+ (void)GO_TO_SCREEN:(UIViewController *)delegate destiny:(NSString *)destiny
{
    [delegate performSegueWithIdentifier:destiny sender:delegate];
}

#pragma mark - Push screen
+ (void)PUSH_SCREEN:(UIViewController *)this identifier:(NSString *)ID animated:(BOOL)_animated
{
    [this.navigationController pushViewController:[this.storyboard instantiateViewControllerWithIdentifier:ID] animated:YES];
}

#pragma mark - pop to screen
+ (void)POP_SCREEN:(UIViewController *)this identifier:(NSString *)ID animated:(BOOL)_animated
{
    id vc = [this.storyboard instantiateViewControllerWithIdentifier:ID];
    UIViewController *newVC = vc;
    NSMutableArray *vcs =  [NSMutableArray arrayWithArray:this.navigationController.viewControllers];
    [vcs insertObject:newVC atIndex:[vcs count]-1];
    [this.navigationController setViewControllers:vcs animated:NO];
    [this.navigationController popViewControllerAnimated:YES];
}

#pragma mark - keyBoard bar
+ (void)SEARCH_BAR_ADD_KEYBOARD_BAR:(NSArray *)listField delegate:(id)_delegate done:(SEL)_done cancel:(SEL)_cancel
{
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem *btnCancel = [[UIBarButtonItem alloc]initWithTitle:@"Cancelar" style:UIBarButtonItemStyleBordered target:_delegate action:_cancel];
    
    UIBarButtonItem * btnConfirm = [[UIBarButtonItem alloc]initWithTitle:@"Confirmar" style:UIBarButtonItemStyleDone target:_delegate action:_done];
    numberToolbar.items = [NSArray arrayWithObjects:
                           btnCancel,
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           btnConfirm,
                           nil];
    [numberToolbar sizeToFit];
    
    for (UISearchBar *tmp in listField)
    {
        [tmp setDelegate:_delegate];
        [tmp setInputAccessoryView:numberToolbar];
    }
}

#pragma mark - keyBoard bar
+ (void)KEYBOARD_ADD_BAR:(NSArray *)listField delegate:(id)_delegate change:(SEL)_change done:(SEL)_done cancel:(SEL)_cancel
{
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem *btnCancel = [[UIBarButtonItem alloc]initWithTitle:@"Cancelar" style:UIBarButtonItemStyleBordered target:_delegate action:_cancel];
    
    UIBarButtonItem * btnConfirm = [[UIBarButtonItem alloc]initWithTitle:@"Confirmar" style:UIBarButtonItemStyleDone target:_delegate action:_done];
    numberToolbar.items = [NSArray arrayWithObjects:
                           btnCancel,
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           btnConfirm,
                           nil];
    [numberToolbar sizeToFit];
    
    for (UITextField *tmp in listField)
    {
        [tmp setDelegate:_delegate];
        [tmp setInputAccessoryView:numberToolbar];
        [tmp addTarget:_delegate
                action:_change
      forControlEvents:UIControlEventEditingChanged];
    }
}

#pragma mark - Scroll UP
+ (void)TEXT_SCREEN_UP:(UIViewController *)delegate textView:(UITextView *)textView frame:(CGRect)frame
{
    CGFloat y = 550 - textView.center.y;
    if (y < 300)
    {
        float extra = 300 - y;
        frame = delegate.view.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        delegate.view.frame = CGRectMake(0,-extra,320,550);
        [UIView commitAnimations];
    }
}

#pragma mark - Scroll DOWN
+ (void)TEXT_SCREEN_DOWN:(UIViewController *)delegate textField:(UITextField *)textView frame:(CGRect)frame
{
    CGRect returnframe = delegate.view.frame;
    if (returnframe.origin.y != frame.origin.y){
        returnframe.origin.y = 0;
        [UIView animateWithDuration:0.2 animations:^{delegate.view.frame = frame;}];
    }
}

#pragma mark - Scroll UP
+ (void)TEXT_VIEW_SCREEN_UP:(UIViewController *)delegate textView:(UITextView *)textView frame:(CGRect)frame
{
    CGFloat y = 545 - textView.center.y;
    if (y < 300)
    {
        float extra = 300 - y;
        frame = delegate.view.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        delegate.view.frame = CGRectMake(0,-extra,320,545);
        [UIView commitAnimations];
    }
}

#pragma mark - Touch cell Delay
+ (void)TABLE_CELL_NO_TOUCH_DELAY:(UITableViewCell *)cell
{
    for (id obj in cell.subviews)
    {
        if ([NSStringFromClass([obj class]) isEqualToString:@"UITableViewCellScrollView"])
        {
            UIScrollView *scroll = (UIScrollView *) obj;
            scroll.delaysContentTouches = NO;
            break;
        }
    }
}

#pragma mark - Horizontal Picker
+ (UIPickerView *)HORIZONTAL_PICKER:(id)_delegate view:(UITableViewCell *)_view center:(CGPoint)center imageName:(NSString *)name
{
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    [picker setBackgroundColor:[UIColor clearColor]];
    [picker setShowsSelectionIndicator:NO];
    [picker setDataSource:_delegate];
    [picker setDelegate:_delegate];
    CGAffineTransform rotate = CGAffineTransformMakeRotation(-3.14/2);
    rotate = CGAffineTransformScale(rotate, .1, 1.8);
    [picker setTransform:rotate];
    [picker setCenter:CGPointMake(picker.center.x, center.y + 25)];
    
    UIImage *selectorImage  = [UIImage imageNamed:name];
    UIView  *customSelector = [[UIImageView alloc] initWithImage:selectorImage];
    [customSelector setFrame:CGRectMake(0, 0,
                                        [picker rowSizeForComponent:0].width,
                                        [picker rowSizeForComponent:0].height+2)];
    [customSelector setCenter:CGPointMake(picker.center.x, picker.center.y)];
    [_view addSubview:customSelector];
    [_view addSubview:picker];
    
    return picker;
}

#pragma mark - Horizontal Picker TEXT
+ (UILabel *)HORIZONTAL_PICKER_TEXT:(NSString *)text
{
    CGRect   rect  = CGRectZero;
    UILabel *label = [[UILabel alloc]initWithFrame:rect];
    [label setText:text];
    [label setFont:[UIFont fontWithName:FONT_NAME_BOLD size:50]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setClipsToBounds:YES];
    CGAffineTransform rotate = CGAffineTransformMakeRotation(3.14/2);
    rotate = CGAffineTransformScale(rotate, .1, 1.8);
    [label setTransform:rotate];
    return label;
}

@end
