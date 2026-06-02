using {AdminService} from './admin-service';

annotate AdminService.Books with {
    title @mandatory;
    author @assert.target;
    genre @mandatory @assert.target;
    price @assert.range: [1, 11];
    stock @assert.range: [(0), _];
}

annotate AdminService.Orders with{
    book @mandatory @assert.target;
    quantity @assert.range: [1, _];
}