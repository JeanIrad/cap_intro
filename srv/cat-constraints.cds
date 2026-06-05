using {CatlogService} from './cat-service';


annotate CatlogService.Reviews with {
    book @assert.target;
    rating @mandatory @assert.range: [1, 5];
};

