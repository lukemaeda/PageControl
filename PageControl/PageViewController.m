//
//  PageViewController.m
//  PageControl
//
//  Created by MAEDA HAJIME on 2014/05/27.
//  Copyright (c) 2014年 HAJIME MAEDA. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()
{
    BOOL pageControlBeingUsed;
    
    NSMutableArray *myObject;
}

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation PageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    myObject = [[NSMutableArray alloc] init];

    [myObject addObject:@"img01"];
    [myObject addObject:@"img02"];
    [myObject addObject:@"img03"];
    [myObject addObject:@"img04"];

    pageControlBeingUsed = NO;

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    //CGFloat screenHight = screenRect.size.height;
    
    for (int i = 0; i < [myObject count]; i++) {

        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;
        
        NSString *val = [myObject objectAtIndex:i];
        
        UIImage* theImage = [UIImage imageNamed:val];
        
        //UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(screenWidth*i,0,theImage.size.width ,theImage.size.height)];

        // screenWidth 高さ調節
        UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(screenWidth*i,0,screenWidth ,580)];

        img.image = theImage;

        [self.scrollView addSubview:img];
    }

    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * [myObject count], self.scrollView.frame.size.height-100);
    
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = [myObject count];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {

    if (!pageControlBeingUsed) {

        // Switch the indicator when more than 50% of the previous/next page is visible

        CGFloat pageWidth = self.scrollView.frame.size.width;

        int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;

        self.pageControl.currentPage = page;
    }

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    pageControlBeingUsed = NO;

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    pageControlBeingUsed = NO;

}

- (IBAction)changePage {

    // Update the scroll view to the appropriate page

    CGRect frame;

    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];

    pageControlBeingUsed = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
