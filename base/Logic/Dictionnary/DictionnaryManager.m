//
//  DictionnaryManager.m
//  base
//
//  Created by rebecca biaz on 10/14/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "DictionnaryManager.h"

@implementation DictionnaryManager

static DictionnaryManager *sharedInstance = nil;

+ (DictionnaryManager *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {
            sharedInstance = [DictionnaryManager load];
            if (sharedInstance == nil)
            {
                sharedInstance = [[self alloc] init];
            }
        }
    }
    return sharedInstance;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (NSString *)pathForSave
{
    NSMutableString *pathSave = [[self class] dictionnaryPath];
   
    if ([[UserManager sharedInstance] currentStudent])
    {
        [pathSave appendFormat:@"/%@", [[UserManager sharedInstance] currentStudent].name];
    }
    else
    {
        [pathSave appendFormat:@"/defaultStudent"];
    }
    return pathSave;
}

+ (NSMutableString *)dictionnaryPath
{
    NSMutableString *dictionnaryPath = [NSMutableString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(), NSStringFromClass([self class])];
    if ([[UserManager sharedInstance] currentTeacher])
    {
        [dictionnaryPath appendFormat:@"/%@", [[UserManager sharedInstance] currentTeacher].name];
    }
    else
    {
        [dictionnaryPath appendFormat:@"/defaultTeacher"];

    }

    return dictionnaryPath;
}

- (void) save
{
    NSString *path = [[self class] pathForSave];
    NSString *dictionnaryPath = [[self class] dictionnaryPath];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    NSFileManager *fManager = [NSFileManager defaultManager];
    if ([fManager fileExistsAtPath:path])
    {
        [fManager removeItemAtPath:path error:nil];
    }
    BOOL isDirectory = NO;
    NSError *error = nil;

    if (![fManager fileExistsAtPath:dictionnaryPath isDirectory:&isDirectory])
    {
        [fManager createDirectoryAtPath:dictionnaryPath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    [fManager createFileAtPath:path contents:data attributes:nil];
}

- (id)init
{
    if (self = [super init])
    {
        [self initialize:nil];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:_words forKey:@"words"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        _words = [aDecoder decodeObjectForKey:@"words"];
        
        [self initialize:aDecoder];
    }
    return self;
}

- (void)initialize:(NSCoder *)aDecoder
{
    if (!_words)
    {
        _words = [NSMutableArray array];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logedOut:) name:TEACHER_STATUS_NOTIFICATION object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(studentChoosed:) name:STUDENT_STATUS_NOTIFICATION object:nil];
}

- (NSArray *)words
{
    return _words;
}

- (BOOL)addWordInfo:(WordInfo *)wordInfo
{
    [_words addObject:wordInfo];
    [self save];
    
    return YES;
}

- (void)logedOut:(NSNotification *)notification
{
    sharedInstance = nil;
}

- (void)studentChoosed:(NSNotification *)notification
{
    sharedInstance = nil;
}

@end
