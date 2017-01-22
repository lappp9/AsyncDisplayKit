//
//  ASDisplayNodeLayerBackingTests.m
//  AsyncDisplayKit
//
//  Created by Luke Parham on 12/4/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import <XCTest/XCTest.h>


#import "ASDisplayNode.h"
#import "ASControlNode.h"
#import "ASDisplayNodeTestsHelper.h"

@interface ASDisplayNode (Testing)
- (void)_loadViewOrLayerIsLayerBacked:(BOOL)isLayerBacked;
@end

@interface ASDisplayNodeLayerBackingTests : XCTestCase

@end

@implementation ASDisplayNodeLayerBackingTests

- (void)testShouldBeLayerBackedWhenLayerIsAccessed
{
  ASDisplayNode *node = [[ASDisplayNode alloc] init];
  node.shouldAutomaticallyLayerBack = YES;
  
  [node layer];
  
  XCTAssert(node.isLayerBacked);
}

- (void)testShouldNotBeLayerBackedIfTheyHaveATargetActionPair
{
  ASControlNode *node = [[ASControlNode alloc] init];
  node.shouldAutomaticallyLayerBack = YES;
  [node addTarget:[NSNull null] action:@selector(layer) forControlEvents:ASControlNodeEventTouchCancel];
  
  [node layer];
  
  XCTAssertFalse(node.isLayerBacked);
}

- (void)testNodeThatCouldBeLayerBackedShouldAssertOnViewAccess
{
  ASDisplayNode *node = [[ASDisplayNode alloc] init];
  node.shouldAutomaticallyLayerBack = YES;
  
  ASDisplayNode *subnode = [[ASDisplayNode alloc] init];
  [node addSubnode:subnode];
  
  XCTAssertThrows(subnode.view);
}

//1) Should this be a hierarchy thing?
//2) What other cases are there to be aware of?  This needs to automatically happen in the _loadViewOr... method


@end
