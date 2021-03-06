//
//  UIImageView+Addition.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-9.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "UIImageView+Addition.h"
#import "Image+Addition.h"
#import "UIView+Addition.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIImageView (Addition)

- (void)loadImageFromURL:(NSString *)urlString 
              completion:(void (^)(BOOL succeed))completion 
          cacheInContext:(NSManagedObjectContext *)context {	
    Image *image = [Image imageWithURL:urlString inManagedObjectContext:context];
    if(image.image) {
        UIImage *img = image.image;
        if(self.image == nil) {
            self.image = img;
            [self fadeIn];
        } else 
            self.image = img;
        if(completion) {
            completion(YES);
        }
        return;
    }
    
    self.image = nil;
    
    NSURL *url = [NSURL URLWithString:urlString];    
    dispatch_queue_t downloadQueue = dispatch_queue_create("downloadImageQueue", NULL);
    dispatch_async(downloadQueue, ^{ 
        //NSLog(@"download image:%@", urlString);
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        if(!imageData) {
            if (completion) {
                completion(NO);
            }
            return;
        }
        UIImage *img = [UIImage imageWithData:imageData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [Image insertImage:imageData withURL:urlString inManagedObjectContext:context];
            self.image = img;
            [self fadeIn];
            if (completion) {
                completion(YES);
            }			
        });
    });
    dispatch_release(downloadQueue);
}

- (void)loadImageFromURL:(NSString *)urlString cacheInContext:(NSManagedObjectContext *)context {
    [self loadImageFromURL:urlString completion:nil cacheInContext:context];
}

- (CGFloat)contentScaleFactor {
    CGFloat widthScale = self.bounds.size.width / self.image.size.width;
    CGFloat heightScale = self.bounds.size.height / self.image.size.height;
    
    if (self.contentMode == UIViewContentModeScaleToFill) {
        return (widthScale==heightScale) ? widthScale : NAN;
    }
    if (self.contentMode == UIViewContentModeScaleAspectFit) {
        return MIN(widthScale, heightScale);
    }
    if (self.contentMode == UIViewContentModeScaleAspectFill) {
        return MAX(widthScale, heightScale);
    }
    return 1.0;
}

- (void)configureShadow {
    [self.layer setShadowOffset:CGSizeMake(0, 0)];
    [self.layer setShadowRadius:3.0f];
    [self.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.layer setShadowOpacity:0.4f];
    [self.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.layer setBorderWidth:2.0f];
}
  
@end
