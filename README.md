# JCParallaxHeaderView
JCParallaxHeader 封装了一套UIScrollView下拉头部效果，一共有四种效果
附带一个圆形进度效果

支持UIScrollView UITableView UICollectionView UIWebView
并且都可以使用stroyBorad xib 方式实现

typedef enum : NSUInteger {

    JCParallaxModelTopFill,
    JCParallaxModelTopFillFixed,
    JCParallaxModelCenter,
    JCParallaxModelStick,
} JCParallaxModel;

##效果
![image](./parallaxHeaderDemo.gif)