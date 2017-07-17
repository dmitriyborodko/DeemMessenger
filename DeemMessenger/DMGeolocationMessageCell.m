//
//  DMGeolocationMessageCell.m
//  DeemMessenger
//
//  Created by ALS_Deem on 10/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import "DMGeolocationMessageCell.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface DMGeolocationMessageCell ()

@property (weak, nonatomic) IBOutlet MKMapView *activeObject;

@end

@implementation DMGeolocationMessageCell

@synthesize activeObject = _mapView;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupWith:(DMMessage *)message {
    [super setupWith:message];
    
    _mapView.hidden = YES;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        if (message.body) {
            NSArray *coordinateArray = [message.body componentsSeparatedByString:@"::"];
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake((CLLocationDegrees)[((NSString *)[coordinateArray firstObject]) doubleValue],
                                       (CLLocationDegrees)[((NSString *)[coordinateArray lastObject]) doubleValue]);
            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500, 500);
            
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            [annotation setCoordinate:coordinate];
            [annotation setTitle:message.sender.name];
            
            dispatch_async(dispatch_get_main_queue(), ^(void){
                _mapView.hidden = NO;
                [_mapView setRegion:region animated:NO];
                [_mapView addAnnotation:annotation];
            });
        }
    });
}

@end
