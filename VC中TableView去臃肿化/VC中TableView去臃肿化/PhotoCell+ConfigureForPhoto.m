//
//  PhotoCell+ConfigureForPhoto.m
//  objc.io example project (issue #1)
//


#import "PhotoCell+ConfigureForPhoto.h"
#import "Photo.h"


@implementation PhotoCell (ConfigureForPhoto)

- (void)configureForPhoto:(Photo *)photo
{
    self.photoTitleLabel.text = photo.title;
    self.photoAuthorLabel.text = photo.author;
}

@end
