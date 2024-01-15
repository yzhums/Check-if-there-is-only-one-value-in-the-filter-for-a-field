pageextension 50100 GeneralLedgerEntriesExt extends "General Ledger Entries"
{
    actions
    {
        addafter(ReverseTransaction)
        {
            action(GetFilter)
            {
                Caption = 'Get Filter';
                Promoted = true;
                PromotedCategory = Process;
                Image = GetActionMessages;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Message(Rec.GetFilter("G/L Account No."))
                end;
            }
            action(CheckFilter)
            {
                Caption = 'Check Filter';
                Promoted = true;
                PromotedCategory = Process;
                Image = DefaultFault;
                ApplicationArea = All;

                //Method 01
                trigger OnAction()
                begin
                    if (Rec.GetFilter("G/L Account No.") = '') or
                    (StrPos(Rec.GetFilter("G/L Account No."), '|') <> 0) or
                    (StrPos(Rec.GetFilter("G/L Account No."), '>') <> 0) or
                    (StrPos(Rec.GetFilter("G/L Account No."), '<') <> 0) or
                    (StrPos(Rec.GetFilter("G/L Account No."), '*') <> 0) or
                    (StrPos(Rec.GetFilter("G/L Account No."), '?') <> 0) or
                    (StrPos(Rec.GetFilter("G/L Account No."), '..') <> 0) or
                    (StrPos(Rec.GetFilter("G/L Account No."), '@') <> 0) or
                    (StrPos(Rec.GetFilter("G/L Account No."), '&') <> 0) then
                        Message('Contains more than one value in the filter for G/L Account No. field')
                    else
                        Message('Only one value in the filter for G/L Account No. field');
                end;

                //Method 02
                /*trigger OnAction()
                var
                    SpecialChars: Label '|><*?.@&';
                    Len: Integer;
                begin
                    Len := 0;
                    Len := StrLen(DelChr(Rec.GetFilter("G/L Account No."), '=', DelChr(Rec.GetFilter("G/L Account No."), '=', SpecialChars)));
                    if (Rec.GetFilter("G/L Account No.") = '') or (Len > 0) then
                        Message('Contains more than one value in the filter for G/L Account No. field')
                    else
                        Message('Only one value in the filter for G/L Account No. field');
                end;*/

                //Method 03
                /*trigger OnAction()
                var
                    SpecialChars: Label '|><*?.@&';
                    CurrentLetter: Text;
                    i: Integer;
                begin
                    i := 0;
                    foreach CurrentLetter in SpecialChars do begin
                        if StrPos(Rec.GetFilter("G/L Account No."), CurrentLetter) > 0 then
                            i += 1;
                    end;
                    if (Rec.GetFilter("G/L Account No.") = '') or (i > 0) then
                        Message('Contains more than one value in the filter for G/L Account No. field')
                    else
                        Message('Only one value in the filter for G/L Account No. field');
                end;*/
            }
        }
    }
}
