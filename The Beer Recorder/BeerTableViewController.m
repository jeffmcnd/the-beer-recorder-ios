//
//  BeerTableViewController.m
//  The Beer Recorder
//
//  Created by Jeffrey McNally-Dawes on 2013-09-29.
//  Copyright (c) 2013 Jeffrey McNally-Dawes. All rights reserved.
//

#import "BeerTableViewController.h"

@interface BeerTableViewController ()

@end

@implementation BeerTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    [self getBeers];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSMutableArray * mutableBeerNames = [[NSMutableArray alloc] init];
    NSMutableArray * mutableBeerPictures = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < 7; i++) {
        [mutableBeerNames addObject:@"Blue Buck"];
        [mutableBeerPictures addObject:[UIImage imageNamed:@"blue_buck.jpg"]];
    }
    
    _beerNames = [[NSArray alloc] initWithArray:mutableBeerNames];
    _beerPictures = [[NSArray alloc] initWithArray:mutableBeerPictures];
    
    FMDBDataAccess * db = [[FMDBDataAccess alloc] init];
    
    _beers = [[NSArray alloc] initWithArray:[db getBeers]];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)getBeers {
    NSMutableArray * mutableBeerNames = [[NSMutableArray alloc] init];
    NSMutableArray * mutableBeerPictures = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < 7; i++) {
        [mutableBeerNames addObject:@"Blue Buck"];
        [mutableBeerPictures addObject:[UIImage imageNamed:@"blue_buck.jpg"]];
    }
    
    _beerNames = [[NSArray alloc] initWithArray:mutableBeerNames];
    _beerPictures = [[NSArray alloc] initWithArray:mutableBeerPictures];
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_beers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellIdentifier = @"BeerCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Beer * beer = _beers[indexPath.row];
    
    [cell.textLabel setText:beer.beerName];
    [cell.imageView setImage:_beerPictures[indexPath.row]];
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedBeer = _beers[indexPath.row];
    [self performSegueWithIdentifier:@"BeerPageViewController" sender:self];
}

#pragma mark Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"BeerPageViewController"]) {
        BeerPageViewController * bpvc = segue.destinationViewController;
        /*
         Set up all the info necessary.
         */
        [bpvc setPicture:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_beer"]]];
        [bpvc.brewerName setText:_selectedBeer.brewerName];
        [bpvc.appearanceSlider setValue:_selectedBeer.appearance];
        [bpvc.aromaSlider setValue:_selectedBeer.aroma];
        [bpvc.mouthFeelSlider setValue:_selectedBeer.mouthFeel];
        [bpvc.maltHopSlider setValue:_selectedBeer.maltHop];
        [bpvc.flavourSlider setValue:_selectedBeer.flavour];
        [bpvc.overallSlider setValue:_selectedBeer.overall];
        [bpvc.commentTF setText:_selectedBeer.comment];
    }
}

@end
