//
//  AppFunctions.h
//  myPota
//
//  Created by Rodrigo Pimentel on 08/05/14.
//  Copyright (c) 2014 web. All rights reserved.
//
#import "AppDelegate.h"

@interface AppFunctions : NSObject

+ (void)TEXT_FIELD_CONFIG:(UITextField *)_field rect:(CGRect)_rect;

+ (NSDictionary *)DATA_BASE_ENTITY_LOAD:(NSString *)_entity;

+ (BOOL)DATA_BASE_ENTITY_REMOVE:(NSString *)_entity;

+ (NSFetchedResultsController *)DATA_BASE_ENTITY_GET:(NSFetchedResultsController *)_fetchedResultsController delegate:(id)_delegate entity:(NSString *)_entity sort:(NSString *)_sort;

+ (NSManagedObject *)DATA_BASE_ENTITY_ADD:(NSFetchedResultsController *)_fetchedResultsController;

+ (BOOL)DATA_BASE_ENTITY_SAVE:(NSFetchedResultsController *)_fetchedResultsController;

+ (void)APP_LOGOFF:(UIViewController *)view identifier:(NSString *)_id;

+ (void)APP_SELECT_SELLER;

+ (NSString *)GET_TOKEN_DEVICE;

+ (void)LOG_MESSAGE:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel;

#pragma mark - NAVIGATION_BAR
+ (UIViewController *)CONFIGURE_NAVIGATION_BAR:(UIViewController *)screen image:(NSString *)imageName title:(NSAttributedString *)title backLabel:(NSString *)backLabel buttonBack:(SEL)buttonBack openSplitMenu:(SEL)openSplitMenu backButton:(BOOL)backButton;
#pragma mark - NAVIGATION_BAR_CALENDAR
+ (UIViewController *)CONFIGURE_NAVIGATION_BAR_CALENDAR:(UIViewController *)screen image:(NSString *)imageName backLabel:(NSString *)backLabel buttonBack:(SEL)buttonBack;

#pragma mark - SEARCH_BAR_VISUAL
+ (void)CONFIGURE_SEARCH_BAR_VISUAL:(UIView *)searchBar;

#pragma mark - SEARCH_BAR_
+ (void)CONFIGURE_SEARCH_BAR:(UISearchBar *)searchBar delegate:(id)_delegate done:(SEL)_done cancel:(SEL)_cancel;

+ (UIViewController *)BACK_SCREEN:(UIViewController *)screen number:(int)number;
+ (dispatch_queue_t)LOAD_IMAGE_ASYNC:(NSString *)link completion:(void (^)(UIImage *image))block;
+ (NSMutableDictionary *)PLIST_LOAD:(NSString *)name;
+ (NSMutableArray *)PLIST_ARRAY_LOAD:(NSString *)name;
+ (NSString *)PLIST_SAVE:(NSString *)name;
+ (NSMutableDictionary *)PLIST_PATH:(NSString *)name type:(NSString *)type;
+ (NSMutableArray *)PLIST_ARRAY_PATH:(NSString *)name type:(NSString *)type;
+ (UIImage *)APPLY_COLOR:(UIImage *)image color:(UIColor *)color;
/**
 * Função para verificar se o cpf é valido
 * @param "cpf" NSString com o valor a ser testado
 * @returns YES se verdadeiro.
 * @returns NO se falso.
 * @version 1.0
 * @author  Rodrigo
 * @date    20/05/2014
 */
+ (BOOL)VALID_CPF:(NSString *)cpf;
/**
 * Função para definir o tamanho a rolagem maxima da scrollView.
 * Esta função deve ser chamada na viewWillAppear
 * @param "_view"   propria tela.
 * @param "_frame"  frame do objeto mais abaixo na tela
 * @param "_center" centro do objeto mais abaixo na tela
 * @param "_scrollView" scrollView que vc deseja ajustar
 * @author  Rodrigo Pimentel
 * @date    20/05/2014
 * @version 1.0
 * @code
 // Modelo
 - (void)viewWillAppear:(BOOL)animated
 {
    [AppFunctions SET_SCROLL:self
                       frame:CGRect
                      center:CGPoint
                  scrollView:UIScrollView];
 
    [super viewWillAppear:animated];
 }
 * @endcode
 */
+ (void)SET_SCROLL:(UIScrollView *)_view frame:(CGRect)_frame center:(CGPoint)_center;
/**
 * Função para validar se a string é um email
 * @param "email" NSString
 * @returns YES se verdadeiro.
 * @returns NO se falso.
 * @author Rodrigo
 * @date 21/05/2014
 * @version 1.0
 */
+ (BOOL)VALID_MAIL:(NSString *)email;
/**
 * Função para validar se a string contem um numero
 * @param "number" NSString
 * @returns YES se verdadeiro.
 * @returns NO se falso.
 * @author Rodrigo
 * @date 21/05/2014
 * @version 1.0
 */
+ (BOOL)VALID_NUMBER:(NSString *)number;
+ (void)SHOW_OPTIONS:(UIViewController *)main title:(NSString *)_title message:(NSString *)_message cancel:(NSString *)_cancel confirm:(NSString *)_confirm;

+ (int)DIFERENCE_DATE_IN_DAYS:(NSDateComponents *)start end:(NSDateComponents *)end;
+ (int)DIFERENCE_DATE_IN_DAYS_DATE:(NSString *)start end:(NSString *)end;

#pragma mark - keyBoard init
+ (void)INIT_KEYBOARD_CENTER:(UIViewController *)sender willShow:(SEL)willShow willHide:(SEL)willHide;
#pragma mark - textView center screen
+ (void)MOVE_SET_DATA:(UIViewController *)sender notification:(NSNotification *)notification scrollView:(UIScrollView *)scrollView textField:(UITextField *)textField goCenter:(BOOL)goCenter;

+ (void)MOVE_SET_DATA:(UIViewController *)sender notification:(NSNotification *)notification scrollView:(UIScrollView *)scrollView textField:(UITextField *)textField posField:(CGPoint)posField goCenter:(BOOL)goCenter;

#pragma mark - keyBoard finish
+ (void)FINISH_KEYBOARD_CENTER:(UIViewController *)sender;
+ (BOOL)CEP_VALIDATION:(NSString *)code;

#pragma mark - Data Synchron
+ (void)SAVE_INFORMATION:(NSDictionary *)_info tag:(NSString *)_tag;
+ (NSDictionary *)LOAD_INFORMATION:(NSString *)_tag;
+ (void)CLEAR_INFORMATION;

#pragma mark - scroll cell to center
+ (void)SCROLL_RECT_TO_CENTER:(CGRect)visibleRect animated:(BOOL)animated tableView:(UITableView *)_tableView;

#pragma mark - go to screen
+ (void)GO_TO_SCREEN:(UIViewController *)delegate destiny:(NSString *)destiny;

#pragma mark - Push screen
+ (void)PUSH_SCREEN:(UIViewController *)this identifier:(NSString *)ID animated:(BOOL)_animated;

#pragma mark - pop to screen
+ (void)POP_SCREEN:(UIViewController *)this identifier:(NSString *)ID animated:(BOOL)_animated;

#pragma mark - keyBoard bar
+ (void)SEARCH_BAR_ADD_KEYBOARD_BAR:(NSArray *)listField delegate:(id)_delegate done:(SEL)_done cancel:(SEL)_cancel;

#pragma mark - keyBoard bar
+ (void)KEYBOARD_ADD_BAR:(NSArray *)listField delegate:(id)_delegate change:(SEL)_change done:(SEL)_done cancel:(SEL)_cancel;

#pragma mark - Scroll UP
+ (void)TEXT_SCREEN_UP:(UIViewController *)delegate textView:(UITextView *)textBox frame:(CGRect)frame;

#pragma mark - Scroll DOWN
+ (void)TEXT_SCREEN_DOWN:(UIViewController *)delegate textField:(UITextField *)textView frame:(CGRect)frame;

+ (void)TEXT_VIEW_SCREEN_UP:(UIViewController *)delegate textView:(UITextView *)textView frame:(CGRect)frame;

#pragma mark - Touch cell Delay
+ (void)TABLE_CELL_NO_TOUCH_DELAY:(UITableViewCell *)cell;

#pragma mark - Horizontal Picker
+ (UIPickerView *)HORIZONTAL_PICKER:(id)_delegate view:(UITableViewCell *)_view center:(CGPoint)center imageName:(NSString *)name;

#pragma mark - Horizontal Picker TEXT
+ (UILabel *)HORIZONTAL_PICKER_TEXT:(NSString *)text;

+ (void)SCROLL_VIEW_RECT_TO_CENTER:(CGRect)visibleRect animated:(BOOL)animated view:(UIViewController *)_view;
@end
