# RDModalTransition
UIViewController *vc = [UIViewController new];<br> 
self.modalTransitionDelegate = [[RDModalTransitionDelegate alloc] initWithVC:vc];<br> 
vc.transitioningDelegate = self.modalTransitionDelegate;<br> 
vc.modalPresentationStyle = UIModalPresentationCustom;<br> 
[self presentViewController:vc animated:YES completion:nil];
