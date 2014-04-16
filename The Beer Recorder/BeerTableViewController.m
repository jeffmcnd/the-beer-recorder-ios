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
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FMDBDataAccess * db = [[FMDBDataAccess alloc] init];
    
    _beers = [[NSArray alloc] initWithArray:[db getBeers]];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSMutableArray * mutableBeerPictures = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < [_beers count]; i++) {
        UIImage * img = [UIImage imageWithContentsOfFile:[DOC_DIR stringByAppendingPathComponent:[NSString stringWithFormat:@"beer%d", ((Beer *)_beers[i]).beerId]]];
        if(img == nil) img = [UIImage imageNamed:@"blue_buck.jpg"];
        
        [mutableBeerPictures addObject:img];
    }
    
    _beerPictures = [[NSArray alloc] initWithArray:mutableBeerPictures];
    
    [self.tableView reloadData];
}

-(IBAction)addTap:(id)sender {
    UIAlertView * newBeerAV = [[UIAlertView alloc] initWithTitle:@"Name?" message:@"You must have a name for the beer in order to add it." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add",nil];
    [newBeerAV setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [newBeerAV show];
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
    
    BeerCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Beer * beer = _beers[indexPath.row];
    
    [cell.beerName setText:beer.beerName];
    [cell.picture setImage:_beerPictures[indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0f;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedBeer = _beers[indexPath.row];
    _selectedRow = indexPath.row;
    [self performSegueWithIdentifier:@"BeerPageViewController" sender:_beerPictures[_selectedRow]];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        Beer * beer = _beers[indexPath.row];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *path = [DOC_DIR stringByAppendingPathComponent:[NSString stringWithFormat:@"beer%d", beer.beerId]];
        
        if([fileManager fileExistsAtPath:path]) {
            [fileManager removeItemAtPath:path error:nil];
        }
        
        FMDBDataAccess * db = [[FMDBDataAccess alloc] init];
        
        if([db deleteBeer:beer]) {
            _beers = [db getBeers];
            [self.tableView reloadData];
        }
    }
}

#pragma mark Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"BeerPageViewController"]) {
        BeerPageViewController * bpvc = (BeerPageViewController *)segue.destinationViewController;
        
        [bpvc setupBeer:_selectedBeer];
        [bpvc.picture setImage:_beerPictures[_selectedRow]];
    }
}

#pragma mark UIAlertView Delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    Beer * beer = [[Beer alloc] init];
    switch(buttonIndex) {
        case 0:
            break;
        case 1: {
            /*
             Add item to database with name.
             */
            beer.beerName = [[alertView textFieldAtIndex:0] text];
            beer.brewerName = @"";
            beer.appearance = 2.5;
            beer.aroma = 2.5;
            beer.mouthFeel = 2.5;
            beer.maltHop = 2.5;
            beer.flavour = 2.5;
            beer.overall = 2.5;
            beer.comment = @"";
            
            FMDBDataAccess * db = [[FMDBDataAccess alloc] init];
            
            [db insertBeer:beer];
            
            NSMutableArray * beers = [db getBeers];
            _beers = [[NSArray alloc] initWithArray:beers];
            
            NSMutableArray * mutableBeerPictures = [[NSMutableArray alloc] initWithArray:_beerPictures];
            
            [mutableBeerPictures addObject:[UIImage imageNamed:@"blue_buck.jpg"]];
            
            _beerPictures = [[NSArray alloc] initWithArray:mutableBeerPictures];
            
            [self.tableView reloadData];
            break;
        }
        default:
            break;
    }
}
@end
