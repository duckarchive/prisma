-- AlterEnum
-- Generic type (not NBUV-specific) so future national/institutional libraries
-- reuse it, the same way WEBSITE is shared across archive-site adapters.
ALTER TYPE "ResourceType" ADD VALUE 'LIBRARY';
