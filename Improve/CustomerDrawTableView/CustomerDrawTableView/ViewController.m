//
//  ViewController.m
//  CustomerDrawTableView
//
//  Created by X-Liang on 2017/11/16.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "ViewController.h"
#import "CustomerDrawnTableViewCell.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1000;
}


// table with normal XIB based cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CustomDrawnCell";
    
    CustomerDrawnTableViewCell *cell = (CustomerDrawnTableViewCell*)[tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil)
    {
        cell = [[CustomerDrawnTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell setTitle:[NSString stringWithFormat:@"Row %d", indexPath.row]
          subTitle:[NSString stringWithFormat:@"Row %d", indexPath.row]
              time:@"yesterday"
         thumbnail:[UIImage imageNamed:@"ios5"]];
    
    // other initialization goes here
    return cell;
}

@end
