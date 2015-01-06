#import <UIKit/UIKit.h>
#import "AppMenuView.h"

typedef enum {
    MWFSlideDirectionNone,
    MWFSlideDirectionUp,
    MWFSlideDirectionLeft,
    MWFSlideDirectionDown,
    MWFSlideDirectionRight
} MWFSlideDirection;

@class MWFSlideNavigationViewController;

#pragma mark -
@protocol MWFSlideNavigationViewControllerDelegate 
@optional
- (void) slideNavigationViewController:(MWFSlideNavigationViewController *)controller 
                   willPerformSlideFor:(UIViewController *)targetController 
                    withSlideDirection:(MWFSlideDirection)slideDirection
                              distance:(CGFloat)distance
                           orientation:(UIInterfaceOrientation)orientation;
- (void) slideNavigationViewController:(MWFSlideNavigationViewController *)controller
                       animateSlideFor:(UIViewController *)targetController
                    withSlideDirection:(MWFSlideDirection)slideDirection
                              distance:(CGFloat)distance
                           orientation:(UIInterfaceOrientation)orientation;
- (void) slideNavigationViewController:(MWFSlideNavigationViewController *)controller 
                    didPerformSlideFor:(UIViewController *)targetController 
                    withSlideDirection:(MWFSlideDirection)slideDirection
                              distance:(CGFloat)distance
                           orientation:(UIInterfaceOrientation)orientation;
- (NSInteger) slideNavigationViewController:(MWFSlideNavigationViewController *)controller
                   distanceForSlideDirecton:(MWFSlideDirection)direction
                        portraitOrientation:(BOOL)portraitOrientation;
@end

#pragma mark -
@protocol MWFSlideNavigationViewControllerDataSource
@optional
- (UIViewController *) slideNavigationViewController:(MWFSlideNavigationViewController *)controller
                      viewControllerForSlideDirecton:(MWFSlideDirection)direction;
@end

#pragma mark -
@interface MWFSlideNavigationViewController : UIViewController <UIGestureRecognizerDelegate>
{
    UIViewController * _secondaryViewController;
    MWFSlideDirection _panningDirection;
}

@property (nonatomic, unsafe_unretained) id<MWFSlideNavigationViewControllerDelegate> delegate;
@property (nonatomic, unsafe_unretained) id<MWFSlideNavigationViewControllerDataSource> dataSource;
@property (nonatomic, strong) UIViewController * rootViewController;
@property (nonatomic, readonly) MWFSlideDirection currentSlideDirection;
@property (nonatomic, readonly) NSInteger currentPortraitOrientationDistance;
@property (nonatomic, readonly) NSInteger currentLandscapeOrientationDistance;
@property (nonatomic) BOOL panEnabled;

- (id) initWithRootViewController:(UIViewController *)rootViewController;
- (void) slideForViewController:(UIViewController *)viewController 
                      direction:(MWFSlideDirection)direction 
    portraitOrientationDistance:(CGFloat)portraitOrientationDistance
   landscapeOrientationDistance:(CGFloat)landscapeOrientationDistance __attribute__((deprecated));
- (void) slideWithDirection:(MWFSlideDirection)direction;
- (void) slideWithDirectionNoAnimation:(MWFSlideDirection)direction;
@end

#pragma mark -
@interface UIViewController (MWFSlideNavigationViewController)
- (MWFSlideNavigationViewController *) slideNavigationViewController;

@end
